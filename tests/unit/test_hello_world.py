"""Test Hello World."""

from helloworld import hello_world


def test_hello_world():
    """Test hello_world."""
    response = hello_world()
    assert isinstance(response, str) is True
