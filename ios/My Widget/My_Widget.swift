//
//  My_Widget.swift
//  My Widget
//
//  Created by brian.chen[陳弘毅] on 2021/2/25.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date(), text: "LALALA" ,configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), text: "測試 Widget", configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
      
      let userDefault = UserDefaults(suiteName: "group.widget.store")
      let text = userDefault?.value(forKey: "text") as? String ?? "No text!!"
      print("Timeline reloading")
      print(text)
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
          let entry = SimpleEntry(date: entryDate, text: text, configuration: configuration)
            entries.append(entry)
        }
      
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
    let configuration: ConfigurationIntent
}

struct My_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
      ZStack {
        GeometryReader{
          geo in
          Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .clipped()
            
        }
        VStack{
          Text(entry.text)
            .foregroundColor(.white)
            .font(.title)
        }
      }
    }
}

@main
struct My_Widget: Widget {
    let kind: String = "Brian's widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            My_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("測試 Widget")
        .description("這是測試用的 widget")
    }
}

struct My_Widget_Previews: PreviewProvider {
    static var previews: some View {
        My_WidgetEntryView(entry: SimpleEntry(date: Date(), text: "Hello Widget", configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
