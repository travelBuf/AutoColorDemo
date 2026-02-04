# AutoColorDemo
Software for "Titles and Header Auto Changing Color?" on Apple Forums

In ContentView there are 3 version:

  Version 1: While scrolling under the column titles the column titles color changes to DARK mode color and the background changes to black.
            The green header contents changes from black to white.
            
  Version 2: Changed List to ScrollView The column titles now appear ok. the titles were scrolling out of the view. I fixed this with a LazyVStack pinnedViews.
            The green header contents changes from black to white.
            
  Version 3: added  .toolbarColorScheme(.light, for: .navigationBar) to the bottom of ScrollView. Now header and titles appearing to be working as expected.
  Not necessary to change any of the func closures in ContentView

  
  So is this operation a bug in Swift or is this normal operation with Liquid Glass?
