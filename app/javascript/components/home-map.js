
const initMap = () => {
  if (document.getElementById("my_dataviz")){

    const svg = d3.select("svg"),
      width = +svg.attr("width"),
      height = +svg.attr("height");

    // Map and projection
    const projection = d3.geoNaturalEarth1()
      .scale(width / 0.4 / Math.PI)
      .translate([width / 2, height / 2])
      .center([10, 50])

    var g = svg.append("g");
    let path = d3.geoPath().projection(projection);

    // Load external data and boot
    var myJsArray = JSON.parse(document.getElementById("my_dataviz").dataset.countries)
    console.log(myJsArray);

    d3.json("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/world.geojson", function (error, data) {
      // if(error) return console.error(error);

      console.log(data.features)
      // Draw the map
      g.append("g")
        .attr("id", "countries")
        .selectAll("path") // Select path
        .data(data.features)  // Bind geodata
        .enter()
        .append("path")  // Add svg path for each country
        .attr("country", function (d) { return d.properties.name; })
        .attr("fill", function (d) {
          // console.log(d.properties.name);
          // console.log(myJsArray[d.properties.name]);

          if (myJsArray[d.properties.name]) {
            console.log(d.properties.name);
            console.log(myJsArray[d.properties.name]);
            return "#55A630";
          }
          else {
            return "#BBB"
          }
        })
        .style("stroke", "#fff")
        .attr("d", path) // Send geometry data to path function to plot points
        .on("click", function (d) {
          console.log(d);
          d3.select('#title').html(''); // Empty old data from the info page
          d3.select('#color').html(''); // Empty old data from the info page
          d3.select('#status').html(''); // Empty old data from the info page
          d3.select('#content').html(''); // Empty old data from the info page
          d3.select('#test').html(''); // Empty old data from the info page
          d3.select('#quarantine').html(''); // Empty old data from the info page

          d3.select('#title').html(d.properties.name);
          if (myJsArray[d.properties.name]) {
            // d3.select('#status').html(myJsArray[d.properties.name].["status"];
            d3.select('#test').html("Requires test no older than: " + myJsArray[d.properties.name]["test"]);
            d3.select('#quarantine').html("At destination isolate for: " + myJsArray[d.properties.name]["quarantine"]);
            d3.select('#color').html("UK quarantine tier color: " + myJsArray[d.properties.name]["color"]);
            // d3.select('#content').html(myJsArray[d.properties.name]["content"]);
            var id = myJsArray[d.properties.name]["id"];
            d3.select("#link").html(`<a href="/countries/${id}">More Info</a>`);
          }
          else {
            d3.select('#status').html("Closed to Tourists");
          }
        });
    })
  }
}

export { initMap }
