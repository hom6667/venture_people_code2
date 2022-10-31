// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const fieldset = document.querySelector("fieldset");
const toggleButton = document.getElementById("toggle-button");

toggleButton.addEventListener("click", (event) => {
  fieldset.disabled = !fieldset.disabled;
  toggleButton.textContent = fieldset.disabled ? "Enable" : "Disable";
  toggleButton.setAttribute("aria-pressed", `${!fieldset.disabled}`);
});