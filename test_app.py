import pytest
from unittest.mock import patch
from app import calculator
from app import calculator
from app import calculator
from app import calculator
from app import calculator
from app import calculator
from app import calculator
from app import calculator

# Test cases for the calculator function
def test_addition():
    with patch("builtins.input", side_effect=["1", "10", "5"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("The result is: 15.0")

def test_subtraction():
    with patch("builtins.input", side_effect=["2", "10", "5"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("The result is: 5.0")

def test_multiplication():
    with patch("builtins.input", side_effect=["3", "10", "5"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("The result is: 50.0")

def test_division():
    with patch("builtins.input", side_effect=["4", "10", "5"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("The result is: 2.0")

def test_division_by_zero():
    with patch("builtins.input", side_effect=["4", "10", "0"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("Error: Division by zero is not allowed.")

def test_percentage():
    with patch("builtins.input", side_effect=["5", "50"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("The result is: 0.5")

def test_invalid_choice():
    with patch("builtins.input", side_effect=["6", "1", "10", "5"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("Invalid choice. Please try again.")

def test_non_numeric_input():
    with patch("builtins.input", side_effect=["1", "abc", "10", "5"]), patch("builtins.print") as mock_print:
        calculator()
        mock_print.assert_any_call("Invalid input. Please enter numeric values.")