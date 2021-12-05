# Customizing the CSS
By default some of the elements have a certain style/theme to them. All of those are defined in a custom.css file that is located at the root of each theme folder. Theme folder itself is located in `/assets` folder.

## Multiple themes
Any number of theme folders can be stored in the `/assets` folder. And the active theme can be selected by editing this entry in the config and replacing the `default` with the name of the desired theme folder:
```yaml
stylesheet: "/assets/themes/default/custom.css"
```
each theme comes with its own background and set of icons.

## CSS
The default custom.css looks like this:
```css
#pageContainer {
  background: url("/assets/themes/default/backgrounds/bg-sand.jpeg");
  background-size: cover;
}

#page {
  width: 90%;
}

#greetingText {
  color: rgb(255, 255, 255);
}

#dateTimeText {
  color: rgb(255, 255, 255);
}

#applicationsText {
  color: rgb(255, 255, 255);
}

#appList {
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: 5px;
  /* border:rgba(0, 0, 0,0.25); */
  color: rgb(0, 0, 0);
  /* border-style: solid; */
}

#appListTitle {
  background-color: rgba(0, 0, 0, 0.25);
  border-radius: 5px 5px 0px 0px;
  color: rgb(255, 255, 255);
}

#appListItem:hover {
  background-color: rgba(0, 0, 0, 0.25);
}

#appImageIcon {
  /* filter: invert(1); */
}

#appFontIcon {
  color: rgb(255, 255, 255);
}

#appName {
  color: rgb(255, 255, 255);
}

#appLink {
  color: rgb(255, 206, 170);
}

#bookmarksText {
  color: rgb(255, 255, 255);
}

#bookmarkList {
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: 5px;
  color: rgb(0, 0, 0);
}

#bookmarkListTitle {
  background-color: rgba(0, 0, 0, 0.25);
  border-radius: 5px 5px 0px 0px;
  color: rgb(255, 255, 255);
}

#bookmarkListItem:hover {
  background-color: rgba(0, 0, 0, 0.25);
}

#bookmarkImageIcon {
  /* filter: invert(1); */
}

#bookmarkFontIcon {
  color: rgb(255, 255, 255);
}

#bookmarkText {
  color: rgb(255, 255, 255);
}

```