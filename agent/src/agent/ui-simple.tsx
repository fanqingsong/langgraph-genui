import React from 'react';

const SimpleWeatherComponent = (props: { city: string }) => {
  return (
    <div style={{ 
      padding: '20px', 
      border: '2px solid #007bff', 
      borderRadius: '8px', 
      backgroundColor: '#f8f9fa',
      margin: '10px 0'
    }}>
      <h3>🌤️ Weather for {props.city}</h3>
      <p>This is a simple weather component!</p>
    </div>
  );
};

export default {
  weather: SimpleWeatherComponent,
};
