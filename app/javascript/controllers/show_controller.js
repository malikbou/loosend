import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    const popup = new mapboxgl.Popup().setHTML(this.markersValue.info_window)
    // Create a HTML element for your custom marker
    const customMarker = document.createElement("div")
    customMarker.className = "marker"
    customMarker.style.backgroundImage = `url('${this.markersValue.image_url}')`
    customMarker.style.backgroundSize = "contain"
    customMarker.style.width = "50px"
    customMarker.style.height = "50px"

    // Pass the element as an argument to the new marker
    new mapboxgl.Marker(customMarker)
      .setLngLat([this.markersValue.lng, this.markersValue.lat])
      .setPopup(popup)
      .addTo(this.map)
}

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend([ this.markersValue.lng, this.markersValue.lat ])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
