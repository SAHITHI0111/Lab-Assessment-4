import React, { useState } from "react";

function App() {
  const [query, setQuery] = useState("");
  const [countries, setCountries] = useState([]);

  // 🔹 Utility function (API call)
  const fetchCountries = async () => {
    if (!query) return;

    const res = await fetch(
      `https://restcountries.com/v3.1/name/${query}`
    );
    const data = await res.json();

    const result = data.map((item) => ({
      name: item.name.common,
      capital: item.capital ? item.capital[0] : "N/A",
      population: item.population,
      region: item.region,
      flag: item.flags.png
    }));

    setCountries(result);
  };

  return (
    <div style={{ textAlign: "center", fontFamily: "Arial" }}>
      
      {/* Header Component */}
      <h1 style={{ background: "#2c3e50", color: "white", padding: "10px" }}>
        🌍 Country Explorer
      </h1>

      {/* Search Component */}
      <input
        type="text"
        placeholder="Enter country name"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        style={{ padding: "10px", margin: "10px", width: "250px" }}
      />

      <button
        onClick={fetchCountries}
        style={{
          padding: "10px",
          background: "#2c3e50",
          color: "white",
          border: "none"
        }}
      >
        Search
      </button>

      {/* CountryList + CountryCard */}
      <div
        style={{
          display: "grid",
          gridTemplateColumns: "repeat(auto-fit, minmax(200px, 1fr))",
          gap: "20px",
          padding: "20px"
        }}
      >
        {countries.map((country, index) => (
          <div
            key={index}
            style={{
              border: "1px solid #ccc",
              padding: "10px",
              borderRadius: "10px"
            }}
          >
            <img
              src={country.flag}
              alt="flag"
              style={{ width: "100px", height: "60px" }}
            />
            <h3>{country.name}</h3>
            <p><b>Capital:</b> {country.capital}</p>
            <p><b>Population:</b> {country.population}</p>
            <p><b>Region:</b> {country.region}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
export default App;
