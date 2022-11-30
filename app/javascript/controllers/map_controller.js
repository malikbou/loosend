import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    marker: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.#addMarkerToMap()
    this.#fitMapToMarker()
  }
  // for toilet index page
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "15px"
      customMarker.style.height = "15px"

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  // Solo marker - Toilet Show
  #addMarkerToMap() {
    const popup = new mapboxgl.Popup().setHTML(this.markerValue.info_window)
    // Create a HTML element for your custom marker
    const newMarker = document.createElement("div")
    newMarker.className = "marker"
    newMarker.style.backgroundImage = `url('${this.markerValue.image_url}')`
    newMarker.style.backgroundSize = "contain"
    newMarker.style.width = "50px"
    newMarker.style.height = "50px"

    // Pass the element as an argument to the new marker
    new mapboxgl.Marker(newMarker)
      .setLngLat([this.markerValue.lng, this.markerValue.lat])
      .setPopup(popup)
      .addTo(this.map)
}

  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend([ this.markerValue.lng, this.markerValue.lat ])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
