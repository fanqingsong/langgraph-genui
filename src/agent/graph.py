"""LangGraph Generative UI Agent.

A simple weather agent that demonstrates generative UI components.
"""

import uuid
from typing import Annotated, Sequence, TypedDict

from langchain_core.messages import AIMessage, BaseMessage
from langgraph.graph import StateGraph
from langgraph.graph.message import add_messages
from langgraph.graph.ui import AnyUIMessage, push_ui_message, ui_message_reducer


class WeatherOutput(TypedDict):
    """Weather output with city information."""

    city: str


class AgentState(TypedDict):
    """Agent state with messages and UI components."""

    messages: Annotated[Sequence[BaseMessage], add_messages]
    ui: Annotated[Sequence[AnyUIMessage], ui_message_reducer]


async def weather(state: AgentState) -> dict[str, list[AIMessage]]:
    """Weather node that generates UI components."""
    # For this demo, we'll extract city from the last user message
    # In a real implementation, you'd use structured output with ChatOpenAI
    last_message = state["messages"][-1] if state["messages"] else None
    user_input = last_message.content if last_message else ""

    # Ensure user_input is a string for processing
    if isinstance(user_input, list):
        user_input = " ".join(str(item) for item in user_input)
    user_input = str(user_input)

    # Simple city extraction (in real implementation, use structured output)
    city = "San Francisco"  # Default city
    if "london" in user_input.lower():
        city = "London"
    elif "new york" in user_input.lower():
        city = "New York"
    elif "tokyo" in user_input.lower():
        city = "Tokyo"

    weather_data: WeatherOutput = {"city": city}

    message = AIMessage(
        id=str(uuid.uuid4()), content=f"Here's the weather for {weather_data['city']}"
    )

    # Emit UI elements associated with the message
    push_ui_message("weather", dict(weather_data), message=message)

    return {"messages": [message]}


# Define the graph
graph = (
    StateGraph(AgentState)
    .add_node("weather", weather)
    .add_edge("__start__", "weather")
    .compile()
)
