"""Configuration file for pytest."""
# adapted from hstrat
# https://github.com/mmore500/hstrat/blob/1bfac67849c51bd1b82fd6010487906196136be8/tests/test_hstrat/conftest.py

import random

import numpy as np
import pytest


@pytest.fixture(autouse=True)
def reseed_random(request: pytest.FixtureRequest) -> None:
    """Reseed random number generator to ensure determinstic test."""
    random.seed(request.node.name)
    np.random.seed(random.randint(1, 2**32))
