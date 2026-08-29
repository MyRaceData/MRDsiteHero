import Component from "@glimmer/component";
import { service } from "@ember/service";
import { apiInitializer } from "discourse/lib/api";
import { defaultHomepage } from "discourse/lib/utilities";

class HomepageOnly extends Component {
  @service router;

  get shouldShow() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  <template>
    {{#if this.shouldShow}}
        <div class="mrd-widget-container" style="margin-bottom: 24px;">
            <!-- Column 1: YouTube Widget -->
            <div class="mrd-widget ww" style="white-space: nowrap; padding-bottom: 10px; background-color: rgb(0,0,0,.5); height: 100%;">
                <h2 style="text-align: center;">Watch My Race Data on</h2>
                <div style="width: 200px; display: block; margin: 0 auto;">
                  <a href="https://www.youtube.com/@myracedatacom/streams" target="_blank" rel="noopener noreferrer" style="display: block; height: 60px; width: 180px; background-image: url('https://www.myracedata.com/images/Youtube-white.png'); background-size: cover; background-color: black; border-radius: 8px; border: 1px solid white;"></a>
                </div>
            </div>
        
            <!-- Column 2: Weather Widget -->
            <div class='ww mrd-widget'>
                <a href="https://myracedata.com/weather" style="color: #FFF;">
                    <div id="weather-widget-container">
                        Fetching current weather...
                    </div>
                </a>
            </div>
        </div>
    {{/if}}
  </template>
}
export default apiInitializer((api) => {
  api.renderInOutlet("above-main-container", HomepageOnly);
  api.onPageChange(() => {
  const myWidget = document.querySelector("#weather-widget-container");
  if (myWidget) {
    window.loadWeatherWidget();
  }
  });
  api.renderInOutlet("discovery-navigation-bar-above",
    <template>
        <div>
             <hr />
             <h2>
                My Race Data Community forum
             </h2>
        </div>
    </template>
    );
});
