//
//  MementoWidgetLiveActivity.swift
//  MementoWidget
//
//  Created by Jayant Godse on 27/1/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MementoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MementoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MementoWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MementoWidgetAttributes {
    fileprivate static var preview: MementoWidgetAttributes {
        MementoWidgetAttributes(name: "World")
    }
}

extension MementoWidgetAttributes.ContentState {
    fileprivate static var smiley: MementoWidgetAttributes.ContentState {
        MementoWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MementoWidgetAttributes.ContentState {
         MementoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MementoWidgetAttributes.preview) {
   MementoWidgetLiveActivity()
} contentStates: {
    MementoWidgetAttributes.ContentState.smiley
    MementoWidgetAttributes.ContentState.starEyes
}
