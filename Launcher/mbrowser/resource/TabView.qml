import Qt 4.7

Item {
    id: tabView

    Component {
        id: tabViewDelegate

        TabViewItem {
            id: tabItem
        }
    }
}
