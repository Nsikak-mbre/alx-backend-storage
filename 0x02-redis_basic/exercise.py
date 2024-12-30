#!/usr/bin/env python3
"""
Cache module for storing data in Redis.
"""

import redis
import uuid
from functools import wraps
from typing import Union, Callable, Optional


def count_calls(method: Callable) -> Callable:
    """
    Decorator that counts the number of times a method is called.
    """
    key = method.__qualname__
    @wraps(method)

    def wrapper(self, *args, **kwargs):
        # Increment the count for the method
        # using the qualified name as the key
        self._redis.incr(key)
        return method(self, *args, **kwargs)
    return wrapper


def call_history(method: Callable) -> Callable:
    """
    Decorator that stores the history of
    inputs and outputs for a particular function.
    """
    @wraps(method)

    def wrapper(self, *args):
        # Define Redis keys for inputs and outputs
        inputs_key = f"{method.__qualname__}:inputs"
        outputs_key = f"{method.__qualname__}:outputs"

        # Store input arguments in Redis
        self._redis.rpush(inputs_key, str(args))

        # Execute the original method and capture the output
        result = method(self, *args)

        # Store the output in Redis
        self._redis.rpush(outputs_key, str(result))

        # Return the result of the method call
        return result

    return wrapper


class Cache:
    """
    Cache class to store data in Redis.
    """

    def __init__(self):
        """
        Initialize the Cache class, setting up a private Redis client instance
        and flushing the database.
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store data in Redis with a randomly generated key.

        Args:
            data (Union[str, bytes, int, float]): The data to store in Redis.

        Returns:
            str: The randomly generated key under which the data is stored.
        """
        rand_key = str(uuid.uuid4())
        self._redis.set(rand_key, data)
        return rand_key

    def get(self, key: str, fn: Optional[Callable]
            = None) -> Union[str, bytes, int, float, None]:
        """
        Retrieve data from Redis and optionally apply a conversion function.

        Args:
            key (str): The key to retrieve the data.
            fn (Optional[Callable]): A callable to convert
            the data to the desired format.

        Returns:
            Union[str, bytes, int, float, None]: The retrieved
              data in the desired format or None if the key does not exist.
        """
        value = self._redis.get(key)
        if value is None:
            return None
        if fn is not None:
            return fn(value)
        return value

    def get_str(self, key: str) -> str:
        """
        Retrieve a string value from Redis and decode it from bytes to UTF-8.

        Args:
            key (str): The key to retrieve the data.

        Returns:
            str: The retrieved data as a UTF-8 string.
        """
        return self.get(key, fn=lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> int:
        """
        Retrieve an integer value from Redis and convert
        it from bytes to an integer.

        Args:
            key (str): The key to retrieve the data.

        Returns:
            int: The retrieved data as an integer.
        """
        return self.get(key, fn=int)
