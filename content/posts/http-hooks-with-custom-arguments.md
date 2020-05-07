+++
title = "Patching requests HTTP hooks with custom arguments"
author = ["Ben Mezger"]
date = 2020-05-07T18:59:00-03:00
publishDate = 2020-05-07
tags = ["python"]
categories = ["blog"]
draft = false
+++

I am working on a project where we have lots of functions integrated with
external APIs. Functions where HTTP requests get dispatched, we log the current
caller&rsquo;s name, headers, and data (if any) in case we need to debug anything. For
example:

```python
import logging
import requests
LOGGER = logging.getLogger("external")

def create_external_services():
    ...
    LOGGER.info(f"[func] | Request {data}")
    response = requests.post("..")
    LOGGER.info(f"[func] | Response {response.status_code} {response.text}")
    ...

def delete_external_services():
    LOGGER.info(f"[func] | Request {data}")
    response = requests.delete("..")
    LOGGER.info(f"[func] | Response {response.status_code} {response.text}")
```

So far so good, but it gets ugly when you have a bunch of functions logging HTTP
one or multiple requests and responses.

Python&rsquo;s `requests` has a [hook system](https://requests.readthedocs.io/en/master/user/advanced/#event-hooks) that allows us to manipulate portions of
the request process or signal event handling. However, the hook is unable to
receive a custom argument. `requests` requires hooks to have the current
argument definition of: `def hook(response, *args, **kwargs)`, however, you are
unable to pass custom `kwargs` to the hook as `requests` raises a `TypeError` if
any `kwarg` is not recognized.

The way I solved this issue was by first creating a hook patch decorator.

```python
from typing import Callable
import functools
import logging

def patch_http(
    logger: logging.Logger = None,
    level: int = logging.INFO,
    log_hook: Callable = log_hook,
) -> Callable:
    if logger is None:
        logger = logging.getLogger("http.client")

    def decorate_http(func):
        @functools.wraps(func)
        def log_wrapper(*args, **kwargs):
            # fake func and logger attribute to log_hook
            log_hook.func = func
            log_hook.logger = logger
            log_hook.level = level
            return func(*args, **kwargs)

        return log_wrapper

    return decorate_http
```

This decorator decorates functions in which `requests` is used. It allows us to
use a custom logger, log level, and log_hook function if required. `log_wrapper`
creates 3 dummy attributes: `func` which holds the address of the caller, the
logger, and the log level.
The `log_hook` requires some hacking, as we might want to use it without the
need of a decorated function.

```python
def log_hook(req, *args, **kwargs):
    if not hasattr(log_hook, "func"):
        log_hook.func = None
    if not hasattr(log_hook, "logger"):
        setattr(log_hook, "logger", logging.getLogger("http.client"))
    if not hasattr(log_hook, "level"):
        setattr(log_hook, "level", logging.INFO)

    log_hook.logger.log(
        log_hook.level,
        "[{}] | Request | Payload: {}".format(
            log_hook.func.__name__ if callable(log_hook.func) else "",
            req.request.data if hasattr(req.request, "data") else {},
        ),
    )

    log_hook.logger.log(
        log_hook.level,
        "[{}] | Response status {} | Response {}".format(
            log_hook.func.__name__ if callable(log_hook.func) else "",
            req.status_code,
            req.content,
        ),
    )
    return req
```

The first lines are what allows the use of the hook regardless of the decorator,
with the downside of not having a function caller named. The actual call to
logging is done by using the attribute previously created by our `patch_http`
decorator, however, if no decorator is used, it defaults to a predefined
`http.client` logger.
Now the actual change to our code:

```python
import logging
import requests
LOGGER = logging.getLogger("external")

@patch_http(logger=LOGGER)
def create_external_services():
    response = requests.post("..", hooks={"response": log_hook})

@patch_http(logger=LOGGER)
def delete_external_services():
    response = requests.post("..", hooks={"response": log_hook})
```

I am still not entirely convinced is using a decorator for patching the hook is
the cleanest way, however, it allows us to modify the logging messages for all
requests in one place without having to duplicate code or easily add custom
logic to all requests.

For example, say we want to log only if a 404 HTTP status
code gets returned in `create_external_services`. We could modify our decorator
to create an `expected_statuses` and check the response status code in
`log_hook` before logging.

{{< highlight python "linenos=table, linenostart=1" >}}
from typing import Callable, Tuple
import functools
import logging

def patch_http(
logger: logging.Logger = None,
level: int = logging.INFO,
log_hook: Callable = log_hook,
expected_statuses: Tuple[int] = (200, 201)
) -> Callable:
if logger is None:
logger = logging.getLogger("http.client")

    def decorate_http(func):
        @functools.wraps(func)
        def log_wrapper(*args, **kwargs):
            log_hook.expected_statuses = expected_statuses
            log_hook.func = func
            log_hook.logger = logger
            log_hook.level = level
            return func(*args, **kwargs)

        return log_wrapper

    return decorate_http

def log_hook(req, \*args, \*\*kwargs):
...
if not hasattr(log_hook, "expected_statuses"):
setattr(log_hook, "expected_statuses", (200,))

    if req.status_code in log_hook.expected_statuses:
        log_hook.logger.log(
            log_hook.level,
            "[{}] | Request | Payload: {}".format(
                log_hook.func.__name__ if callable(log_hook.func) else "",
                req.request.data if hasattr(req.request, "data") else {},
             ),
        )
        ....
    return req

{{< /highlight >}}
