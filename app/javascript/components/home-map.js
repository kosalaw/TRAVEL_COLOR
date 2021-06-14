const initMap = () => {
  if (document.getElementById("my_dataviz")) {
    const svg = d3.select("svg"),
      width = +svg.attr("width"),
      height = +svg.attr("height");

    // Map and projection
    const projection = d3
      .geoNaturalEarth1()
      .scale(width / 0.4 / Math.PI)
      .translate([width / 2, height / 2])
      .center([10, 50]);

    var g = svg.append("g");
    let path = d3.geoPath().projection(projection);

    // Load external data and boot
    var myJsArray = JSON.parse(
      document.getElementById("my_dataviz").dataset.countries
    );
    console.log(myJsArray);

    let onClick = function (d) {
      console.log(d);
      modal.style.display = "block";
      d3.select("#title").html(""); // Empty old data from the info page
      d3.select("#color").html(""); // Empty old data from the info page
      d3.select("#status").html(""); // Empty old data from the info page
      d3.select("#content").html(""); // Empty old data from the info page
      d3.select("#test").html(""); // Empty old data from the info page
      d3.select("#quarantine").html(""); // Empty old data from the info page
      d3.select("#link").html(""); // Empty old data from the info page

      d3.select("#title").html(d.properties.name);
      if (myJsArray[d.properties.name]) {
        // d3.select('#status').html(myJsArray[d.properties.name].["status"];
        d3.select("#test").html(
          "Requires test no older than: " + myJsArray[d.properties.name]["test"]
        );
        d3.select("#quarantine").html(
          "At destination isolate for: " +
            myJsArray[d.properties.name]["quarantine"]
        );
        d3.select("#color").html(
          "UK quarantine tier color: " + myJsArray[d.properties.name]["color"]
        );
        // d3.select('#content').html(myJsArray[d.properties.name]["content"]);

        let id = myJsArray[d.properties.name]["id"];

        d3.select("#link").html(`<a href="/countries/${id}">More Info</a>`);
      } else {
        d3.select("#status").html("Closed to Tourists");
        let id = myJsArray[d.properties.name]["id"];
        d3.select("#link").html(`<a href="/countries/${id}">More Info</a>`);
      }
    };

    let tooltip = d3.select("div.tooltip");

    d3.json(
      "https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/world.geojson",
      function (error, data) {
        // if(error) return console.error(error);

        console.log(data.features);
        // Draw the map
        g.selectAll("path") // Select path
          .data(data.features) // Bind geodata
          .enter()
          // Add svg path for each country
          .append("path")
          .attr("class", "country")
          .attr("name", function (d) {
            return d.properties.name;
          })
          .attr("d", path) // Send geometry data to path function to plot points
          .attr("fill", function (d) {
            if (myJsArray[d.properties.name]) {
              console.log(d.properties.name);
              console.log(myJsArray[d.properties.name]);
              return "#55A630";
            } else {
              return "#BBB";
            }
          })
          .style("stroke", "#fff")
          .style("opacity", 0.8)
          .on("click", onClick)
          .on("mouseover", function (d, i) {
            d3.select(this)
              .raise()
              .style("opacity", 1)
              .style("stroke", "black");
            return tooltip.style("hidden", false).html(d.properties.name);
          })
          .on("mousemove", function (d) {
            tooltip
              .classed("hidden", false)
              .style("top", d3.event.pageY - 300 + "px")
              .style("left", d3.event.pageX + 10 + "px")
              .html(d.properties.name);
          })
          .on("mouseout", function (d, i) {
            d3.select(this).style("opacity", 0.8).style("stroke", "white");
            tooltip.classed("hidden", true);
          });
      }
    );
  }
};

export { initMap };
