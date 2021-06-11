import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.js'

const initMapbox = () => {
  mapboxgl.accessToken = 'pk.eyJ1IjoiZ2VsYXR0ZSIsImEiOiJja29vODRoOTEwMGp5Mm5zdGVzMGw5NGQ4In0.CuL8g8ROnqHhQiV-nzF2hw';
  const map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/gelatte/ckppbzylq06jd17pdnfmsnbyc',
    center: [12, 55], // starting position
    zoom: 3 // starting zoom
  });
    map();
  }



export { initMapbox };
