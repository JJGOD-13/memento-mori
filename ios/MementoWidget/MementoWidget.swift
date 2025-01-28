//
//  MementoWidget.swift
//  MementoWidget
//
//  Created by Jayant Godse on 27/1/2025.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    private func getDataFromFlutter() -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.MementoApp")
        let textFromApp = userDefaults?.string(forKey: "text_from_memento_app") ?? "0"
        return SimpleEntry(date: Date(), text: textFromApp)
    }
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "Hello World")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        getDataFromFlutter()
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let entry = getDataFromFlutter()

        return Timeline(entries: [entry], policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct MementoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time Left To Live:")
            Text(entry.text)


 
        }
    }
}

struct MementoWidget: Widget {
    let kind: String = "MementoWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MementoWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    MementoWidget()
} timeline: {
    SimpleEntry(date: .now, text: "0")
    SimpleEntry(date: .now, text: "0")
}
