<template>
  <q-page-container
    v-if="configLoaded"
    class="column items-center"
    id="pageContainer"
  >
    <q-page class="q-px-xl q-py-md" id="page">
      <q-input
        :dark="config.dark"
        color="black"
        class="col"
        v-model="keyword"
        placeholder="Search"
        dense
      >
        <template v-slot:append>
          <q-icon name="close" @click="keyword = ''" class="cursor-pointer" />
        </template>
      </q-input>
      <div class="row justify-between">
        <q-item id="greetingText" class="q-px-none q-py-md">
          <q-item-section class="text-h3 text-weight-light">{{
            greetingText
          }}</q-item-section>
        </q-item>
        <q-item id="dateTimeText" class="q-px-xs">
          <q-item-section class="text-h5">{{ dateTime }}</q-item-section>
        </q-item>
      </div>
      <q-item id="applicationsText" class="q-px-xs">
        <q-item-section class="text-h4 text-weight-light"
          >APPLICATIONS</q-item-section
        >
      </q-item>
      <div class="row justify-start">
        <q-item v-if="filteredApplicationGroups.length == 0">
          <q-item-section class="text-h6 text-weight-light"
            >NO MATCHING APPLICATIONS</q-item-section
          >
        </q-item>
        <div
          v-else
          class="col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 q-pa-xs"
          v-for="applicationGroup in filteredApplicationGroups"
          :key="applicationGroup.title"
        >
          <div class="full-height q-pb-xs" id="appList">
            <q-list>
              <q-item dense id="appListTitle">
                <q-item-section class="text-h6 text-weight-light">{{
                  applicationGroup.title
                }}</q-item-section>
              </q-item>
              <div
                v-for="application in applicationGroup.entries"
                :key="application.name"
              >
                <q-item
                  clickable
                  v-if="containsKeyword(application.name)"
                  id="appListItem"
                  @click="openUrl(application.url)"
                >
                  <q-item-section avatar>
                    <q-avatar
                      id="appImageIcon"
                      square
                      size="3em"
                      v-if="isValidPath(application.icon)"
                    >
                      <img :src="application.icon" style="image-rendering: -webkit-optimize-contrast;"/>
                    </q-avatar>
                    <q-icon
                      id="appFontIcon"
                      v-else
                      :name="application.icon"
                      size="3em"
                    />
                  </q-item-section>

                  <q-item-section>
                    <q-item-label
                      id="appName"
                      class="text-subtitle1"
                      lines="2"
                      >{{ application.name }}</q-item-label
                    >
                    <q-item-label
                      v-if="config.showLinks"
                      id="appLink"
                      class="text-caption"
                      lines="1"
                      >{{ application.url }}</q-item-label
                    >
                  </q-item-section>
                </q-item>
              </div>
            </q-list>
          </div>
        </div>
      </div>
      <q-item id="bookmarksText" class="q-px-xs">
        <q-item-section class="text-h5 text-weight-light"
          >BOOKMARKS</q-item-section
        >
      </q-item>
      <div class="row">
        <q-item v-if="filteredBookmarkGroups.length == 0">
          <q-item-section class="text-h6 text-weight-light"
            >NO MATCHING BOOKMARKS</q-item-section
          >
        </q-item>
        <div
          v-else
          class="col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 q-pa-xs"
          v-for="bookmarkGroup in filteredBookmarkGroups"
          :key="bookmarkGroup.title"
        >
          <div class="full-height q-pb-xs" id="bookmarkList">
            <q-list dense>
              <q-item id="bookmarkListTitle">
                <q-item-section class="text-h6 text-weight-light">{{
                  bookmarkGroup.title
                }}</q-item-section>
              </q-item>
              <div
                v-for="bookmark in bookmarkGroup.entries"
                :key="bookmark.name"
              >
                <q-item
                  id="bookmarkListItem"
                  dense
                  clickable
                  v-if="containsKeyword(bookmark.name)"
                  @click="openUrl(bookmark.url)"
                >
                  <q-item-section avatar>
                    <q-avatar
                      id="bookmarkImageIcon"
                      square
                      size="1.2em"
                      v-if="isValidPath(bookmark.icon)"
                    >
                      <img :src="bookmark.icon" />
                    </q-avatar>
                    <q-icon
                      id="bookmarkFontIcon"
                      v-else
                      :name="bookmark.icon"
                      size="1.2em"
                    />
                  </q-item-section>

                  <q-item-section>
                    <q-item-label id="bookmarkText" overline>{{
                      bookmark.name
                    }}</q-item-label>
                  </q-item-section>
                </q-item>
              </div>
            </q-list>
          </div>
        </div>
      </div>
    </q-page>
  </q-page-container>
</template>

<script>
const jsyaml = require("js-yaml");
import axios from "axios";
import moment from "moment";
import { openURL } from "quasar";
import { defineComponent } from "vue";

const configPath = "/assets/config.yml";

export default defineComponent({
  name: "PageIndex",
  components: {},
  data() {
    return {
      configLoaded: false,
      config: null,
      date: null,
      keyword: "",
      borrad: "122px",
    };
  },
  computed: {
    filteredApplicationGroups() {
      var matches = this.config.applications.filter((group) =>
        group.entries.some((entry) =>
          entry.name.toLowerCase().includes(this.keyword.toLowerCase())
        )
      );
      return matches;
    },
    filteredBookmarkGroups() {
      var matches = this.config.bookmarks.filter((group) =>
        group.entries.some((entry) =>
          entry.name.toLowerCase().includes(this.keyword.toLowerCase())
        )
      );
      return matches;
    },
    greetingText() {
      let greeting = "Good day ";
      if (this.date != null) {
        const hour = this.date.hour();
        if (hour >= 0) greeting = "Good night ";
        if (hour >= 6) greeting = "Good morning ";
        if (hour >= 12) greeting = "Good afternoon ";
        if (hour >= 17) greeting = "Good evening ";
        if (hour >= 22) greeting = "Good night ";
      }
      greeting += this.config.author + "!";
      return greeting;
    },
    dateTime() {
      return this.date != null ? this.date.format("MMMM Do YYYY, HH:mm") : "";
    },
  },
  methods: {
    async fetchFiles() {
      // load the config
      var response = await axios({
        method: "get",
        url: configPath,
        headers: {
          "content-type": "text/yaml",
        },
      });
      this.config = jsyaml.load(response.data);
      this.configLoaded = true;

      document.title = this.config.title || "Yet Another Homepage";

      // Load the css
      response = await axios({
        method: "get",
        url: this.config.stylesheet,
        headers: {
          "content-type": "text/css",
        },
      });
      this.createStylesheet(response.data);
      this.updatedate();
    },
    openUrl(url) {
      this.keyword = "";
      openURL(url);
    },
    updatedate() {
      this.date = moment();
    },
    containsKeyword(title) {
      if (this.keyword.length == 0) {
        return true;
      }
      return title.toLowerCase().includes(this.keyword.toLowerCase());
    },
    isValidPath(path) {
      // Check if the path is an actual valid path.
      return /^.*\.[^\/]+$/.test(path);
    },
    createStylesheet: function (css) {
      let style = document.createElement("style");
      style.appendChild(document.createTextNode(css));
      document.head.appendChild(style);
    },
  },
  mounted() {
    this.interval = setInterval(this.updatedate, 1000);
    this.fetchFiles();
  },
  beforeUnmount() {
    clearInterval(this.interval);
  },
});
</script>
