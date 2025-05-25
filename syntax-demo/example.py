#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Python Syntax Highlighting Demo
This module demonstrates various Python syntax elements for highlighting in VSCode.
"""

import os
import sys
import math
from typing import List, Dict, Tuple, Optional, Union, Any
from dataclasses import dataclass
from enum import Enum, auto
import asyncio


# fix name class bellow
class

# todo implement function 
def example_function(number:int, text:str) -> str:
    ...

# Enum definition
class Color(Enum):
    RED = auto()
    GREEN = auto()
    BLUE = auto()
    YELLOW = auto()


# Dataclass
@dataclass
class Point:
    x: float
    y: float
    label: Optional[str] = None
    
    def distance_from_origin(self) -> float:
        """Calculate distance from origin (0, 0)"""
        return math.sqrt(self.x ** 2 + self.y ** 2)


# Class definition
class Shape:
    """Base class for all shapes"""
    
    def __init__(self, name: str):
        self.name = name
        self._area: float = 0.0
    
    @property
    def area(self) -> float:
        """Get the area of the shape"""
        return self._area
    
    @area.setter
    def area(self, value: float) -> None:
        if value < 0:
            raise ValueError("Area cannot be negative")
        self._area = value
    
    def __str__(self) -> str:
        return f"{self.name} with area {self._area:.2f}"
    
    def __repr__(self) -> str:
        return f"Shape(name='{self.name}')"


# Inheritance
class Circle(Shape):
    def __init__(self, name: str, radius: float):
        super().__init__(name)
        self.radius = radius
        self._calculate_area()
    
    def _calculate_area(self) -> None:
        self.area = math.pi * self.radius ** 2


# Function with type hints
def process_data(data: List[int], factor: int = 1) -> Dict[str, Any]:
    """
    Process a list of integers and return statistics
    
    Args:
        data: List of integers to process
        factor: Multiplication factor
    
    Returns:
        Dictionary with statistics
    """
    if not data:
        return {"error": "Empty data"}
    
    processed = [x * factor for x in data]
    
    return {
        "original": data,
        "processed": processed,
        "sum": sum(processed),
        "average": sum(processed) / len(processed),
        "max": max(processed),
        "min": min(processed)
    }


# Async function
async def fetch_data(url: str) -> str:
    """Simulate fetching data from a URL"""
    print(f"Fetching data from {url}")
    await asyncio.sleep(1)  # Simulate network delay
    return f"Data from {url}"


# Context manager
class FileManager:
    def __init__(self, filename: str, mode: str = 'r'):
        self.filename = filename
        self.mode = mode
        self.file = None
    
    def __enter__(self):
        self.file = open(self.filename, self.mode)
        return self.file
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.file:
            self.file.close()


# Decorators
def timer(func):
    """Decorator to measure function execution time"""
    def wrapper(*args, **kwargs):
        import time
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(f"Function {func.__name__} took {end_time - start_time:.4f} seconds to run")
        return result
    return wrapper


@timer
def slow_function(n: int) -> int:
    """A deliberately slow function"""
    import time
    time.sleep(0.1)
    return n * n


# Main execution
if __name__ == "__main__":
    # Variables and basic types
    name = "Python"
    version = 3.10
    is_awesome = True
    complex_number = 3 + 4j
    
    # String formatting
    print(f"{name} {version} is {'awesome' if is_awesome else 'not awesome'}")
    
    # List comprehension
    squares = [x**2 for x in range(10) if x % 2 == 0]
    print(f"Squares of even numbers: {squares}")
    
    # Dictionary comprehension
    char_count = {char: name.count(char) for char in set(name)}
    print(f"Character count in '{name}': {char_count}")
    
    # Lambda function
    double = lambda x: x * 2
    print(f"Double of 5: {double(5)}")
    
    # Using our classes
    point = Point(3, 4, "Example Point")
    print(f"Distance from origin: {point.distance_from_origin()}")
    
    circle = Circle("My Circle", 5)
    print(circle)
    
    # Exception handling
    try:
        result = 10 / 0
    except ZeroDivisionError as e:
        print(f"Error: {e}")
    finally:
        print("Exception handling completed")
    
    # Using our function
    data = [1, 2, 3, 4, 5]
    result = process_data(data, factor=2)
    print(f"Processed data: {result}")
    
    # Run async function
    async def main():
        result = await fetch_data("https://example.com")
        print(result)
    
    # asyncio.run(main())  # Uncomment to run async code
    
    # Using generator
    def fibonacci(n):
        a, b = 0, 1
        for _ in range(n):
            yield a
            a, b = b, a + b
    
    print("Fibonacci sequence:")
    for num in fibonacci(10):
        print(num, end=" ")
    print()
    
    # Call decorated function
    result = slow_function(5)
    print(f"Result: {result}")
