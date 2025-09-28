"""LangGraph Weather Agent.

A simple weather agent that provides weather information.
"""

import uuid
from typing import Annotated, Sequence, TypedDict

from langchain_core.messages import AIMessage, BaseMessage
from langgraph.graph import StateGraph
from langgraph.graph.message import add_messages


class AgentState(TypedDict):
    """Agent state with messages."""

    messages: Annotated[Sequence[BaseMessage], add_messages]


async def weather(state: AgentState) -> dict[str, list[AIMessage]]:
    """Weather node that provides weather information."""
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

    # Mock weather data for different cities
    weather_data = {
        'San Francisco': {
            'temperature': '72°F',
            'condition': 'Partly Cloudy',
            'humidity': '65%',
            'windSpeed': '8 mph',
            'icon': '⛅',
            'description': 'A beautiful day with some clouds'
        },
        'London': {
            'temperature': '59°F', 
            'condition': 'Rainy',
            'humidity': '82%',
            'windSpeed': '12 mph',
            'icon': '🌧️',
            'description': 'Light rain throughout the day'
        },
        'New York': {
            'temperature': '68°F',
            'condition': 'Sunny',
            'humidity': '58%', 
            'windSpeed': '6 mph',
            'icon': '☀️',
            'description': 'Clear skies and sunshine'
        },
        'Tokyo': {
            'temperature': '75°F',
            'condition': 'Partly Sunny',
            'humidity': '70%',
            'windSpeed': '5 mph', 
            'icon': '🌤️',
            'description': 'Warm with occasional clouds'
        }
    }

    # Get weather data for the city
    city_weather = weather_data.get(city, weather_data['San Francisco'])
    
    # Create formatted weather message
    weather_content = f"""# 🌤️ Weather for {city}

**{city_weather['icon']} {city_weather['condition']}**

- **Temperature**: {city_weather['temperature']}
- **Humidity**: {city_weather['humidity']}
- **Wind Speed**: {city_weather['windSpeed']}
- **Description**: {city_weather['description']}

*Weather information provided by the weather agent*"""

    message = AIMessage(
        id=str(uuid.uuid4()), 
        content=weather_content
    )

    return {"messages": [message]}


# Define the graph
graph = (
    StateGraph(AgentState)
    .add_node("weather", weather)
    .add_edge("__start__", "weather")
    .compile()
)
