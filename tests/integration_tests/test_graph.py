from typing import Any

import pytest

from agent import graph

pytestmark = pytest.mark.anyio


async def test_basic_weather_flow() -> None:
    """Test basic weather flow with city extraction."""
    inputs: dict[str, list[Any]] = {"messages": []}

    result = await graph.ainvoke(inputs)  # type: ignore[arg-type]

    assert result is not None
    assert len(result["messages"]) == 1  # assistant message
    assert result["messages"][0].type == "ai"
    assert "weather" in result["messages"][0].content.lower()
    assert "San Francisco" in result["messages"][0].content  # default city


@pytest.mark.skip(reason="LangSmith authentication issue")
async def test_london_weather() -> None:
    """Test weather request for London."""
    from langchain_core.messages import HumanMessage

    inputs = {"messages": [HumanMessage(content="What's the weather in London?")]}

    result = await graph.ainvoke(inputs)  # type: ignore[arg-type]

    assert result is not None
    assert len(result["messages"]) == 2  # human + ai
    assert result["messages"][1].content is not None
    assert "London" in result["messages"][1].content


async def test_new_york_weather() -> None:
    """Test weather request for New York."""
    from langchain_core.messages import HumanMessage

    inputs = {"messages": [HumanMessage(content="Show me New York weather")]}

    result = await graph.ainvoke(inputs)  # type: ignore[arg-type]

    assert result is not None
    assert len(result["messages"]) == 2
    assert "New York" in result["messages"][1].content


async def test_tokyo_weather() -> None:
    """Test weather request for Tokyo."""
    from langchain_core.messages import HumanMessage

    inputs = {"messages": [HumanMessage(content="Tokyo weather please")]}

    result = await graph.ainvoke(inputs)  # type: ignore[arg-type]

    assert result is not None
    assert len(result["messages"]) == 2
    assert "Tokyo" in result["messages"][1].content


async def test_ui_components_present() -> None:
    """Test that UI components are generated in the ui field."""
    from langchain_core.messages import HumanMessage

    inputs = {"messages": [HumanMessage(content="Weather for London")]}

    result = await graph.ainvoke(inputs)  # type: ignore[arg-type]

    assert result is not None
    assert "ui" in result
    # UI components should be present due to push_ui_message call


async def test_message_ids() -> None:
    """Test that messages include proper IDs."""
    from langchain_core.messages import HumanMessage

    inputs = {"messages": [HumanMessage(content="Hello")]}

    result = await graph.ainvoke(inputs)  # type: ignore[arg-type]

    assert result is not None
    assert len(result["messages"]) == 2
    assert result["messages"][0].id is not None
    assert result["messages"][1].id is not None
    assert result["messages"][0].id != result["messages"][1].id
