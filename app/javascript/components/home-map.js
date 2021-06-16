const initMap = () => {
  if (document.getElementById("my_dataviz")) {
    const svg = d3.select("svg"),
      width = +svg.attr("width"),
      height = +svg.attr("height");

    // Map and projection
    const projection = d3
      .geoNaturalEarth1()
      .scale(width / 0.55 / Math.PI)
      .translate([width / 2, height / 2])
      .center([20, 50]);

    var g = svg.append("g");
    let path = d3.geoPath().projection(projection);

    // Load external data and boot
    var myJsArray = JSON.parse(
      document.getElementById("my_dataviz").dataset.countries
    );
    console.log(myJsArray);

    let onClick = function (d) {
      console.log(d);
      myMoodal.style.display = "block";
      d3.select("#name").html(""); // Empty old data from the info page
      d3.select("#color").html(""); // Empty old data from the info page
      d3.select("#status").html(""); // Empty old data from the info page
      d3.select("#content").html(""); // Empty old data from the info page
      d3.select("#test").html(""); // Empty old data from the info page
      d3.select("#quarantine").html(""); // Empty old data from the info page
      d3.select("#link").html(""); // Empty old data from the info page
      d3.select("#name").html(d.properties.name);
      d3.select("#name").style("background-color", "#fff")

      if (myJsArray[d.properties.name]) {
        // d3.select('#status').html(myJsArray[d.properties.name].["status"];
        if (myJsArray[d.properties.name]["test"] === null) {
          d3.select("#test").html("No test required")
        }
        else{
          d3.select("#test").html("Negative test " + "<b>" + myJsArray[d.properties.name]["test"] + "</b>" + " before arrival");
        }

        if (myJsArray[d.properties.name]["quarantine"] === null) {
          d3.select("#quarantine").html("No quarantine required")
        }
        else{
          d3.select("#quarantine").html("Quarantine on arrival: " + "<b>" +myJsArray[d.properties.name]["quarantine"]+ "</b>");
        }
        // d3.select("#color").html(
        //   "UK quarantine tier color: " + myJsArray[d.properties.name]["color"]
        // );
        if (myJsArray[d.properties.name]["color"] === "Amber") {
          d3.select("#name").style("background-color", "#FF8800")
        }
        if (myJsArray[d.properties.name]["color"] === "Green") {
          d3.select("#name").style("background-color", "#55A630")
        }
        if (myJsArray[d.properties.name]["color"] === "Red") {
          d3.select("#name").style("background-color", "#CC0022")
        }
        if (d.properties.name === "Ireland" || d.properties.name === "England"){
          d3.select("#name").style("background-color", "#55A630")
        }
        // d3.select('#content').html(myJsArray[d.properties.name]["content"]);

        let id = myJsArray[d.properties.name]["id"];

        d3.select("#link").html(
          `<a class="btn" href="/countries/${id}">Explore</a>`
        );
      } else {
        d3.select("#status").html("Closed to Tourists");
        // let id = myJsArray[d.properties.name]["id"];
        // d3.select("#link").html(`<a href="/countries/${id}">More Info</a>`);

      }
    };

    let tooltip = d3.select("div.tooltip");
    tooltip.classed("hidden", true);

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
              // console.log(d.properties.name);
              // console.log(myJsArray[d.properties.name]);
              if (myJsArray[d.properties.name]["color"] === "Amber") {
                return "#FF8800";
              }
              if (myJsArray[d.properties.name]["color"] === "Green") {
                return "#55A630";
              }
              if (myJsArray[d.properties.name]["color"] === "Red") {
                return "#CC0022";
              }
              if (d.properties.name === "Ireland"){
                return "#55A630";
              }
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

              .style("top", (d3.mouse(d3.select('#my_dataviz').node()).map( function(d) { return parseInt(d); })[1]) + (250 - 280) + "px")
              .style("left", (d3.mouse(d3.select('#my_dataviz').node()).map( function(d) { return parseInt(d); })[0]) + (250 - 310) + "px")
              if (d.properties.name === "England"){
                tooltip.html("United Kingdom")
              }
              else if (d.properties.name === "Ireland"){
                tooltip.html("Ireland")
              }
              else if (myJsArray[d.properties.name]) {
                tooltip
                  .html(d.properties.name + ": " + myJsArray[d.properties.name]["color"]  + " List country")
                  .style("color", "#fff")

              if (myJsArray[d.properties.name]["color"] === "Amber") {
                tooltip.style("background-color", "#FF8800");
              }
              if (myJsArray[d.properties.name]["color"] === "Green") {
                tooltip.style("background-color", "#55A630");
              }
              if (myJsArray[d.properties.name]["color"] === "Red") {
                tooltip.style("background-color", "#CC0022");
              }
            } else {
              tooltip.html(d.properties.name + ": Closed to UK tourists");
            }
          })
          .on("mouseout", function (d, i) {
            d3.select(this).style("opacity", 0.8).style("stroke", "white");
            tooltip
              .classed("hidden", true)
              .html("")
              .style("background-color", "#fff")
              .style("color", "#000");
          });
      }
    );
  }
};

export { initMap };
