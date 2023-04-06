//
//  WeekCapsule.swift
//  Today
//
//  Created by 李瑞 on 7/3/2023.
//

import SwiftUI
import Charts

enum WeekDay: String, CaseIterable, Identifiable, Plottable {
    case sunday = "Su"
    case monday = "Mo"
    case tuesday = "Tu"
    case wednesday = "We"
    case thursday = "Th"
    case friday = "Fr"
    case saturday = "Sa"


    var id: String {
        return self.rawValue
    }

    var plotValue: Int {
        switch self {
            case .sunday:
                return 0
            case .monday:
                return 1
            case .tuesday:
                return 2
            case .wednesday:
                return 3
            case .thursday:
                return 4
            case .friday:
                return 5
            case .saturday:
                return 6
        }
    }
}

struct WeeklyChart: View {
    @AppStorage("dailyGoal") var goal = 0

    var weekFocusList: FetchedResults<Focus>

    var weekFocus: WeekFocus {
        var week = WeekFocus()
        for focus in weekFocusList {
            week.add(date: focus.startTime, count: focus.duration)
        }
        return week
    }

    var weekColor: Color {
        return weekFocus.total >= goal * 7 ? .green : .purple
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Week:")

                Text("\(weekFocus.total)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(weekColor)
            }
            .padding(.bottom)

            Chart(WeekDay.allCases) { day in
                RuleMark(y: .value("Goal", goal))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                BarMark(
                    x: .value("Weekday", day.rawValue),
                    y: .value("Count", weekFocus.value(of: day))
                )
                .foregroundStyle(weekFocus.value(of: day) >= goal ? Color.green.gradient : Color.purple.gradient)
            }
            .frame(width: 150, height: 130)
            .chartXAxis {
                AxisMarks(values: WeekDay.allCases.map { $0.rawValue }) { value in
                    AxisValueLabel(centered: true)
                }
            }
            .chartYAxis {
                AxisMarks {
                    AxisValueLabel()
                }
            }
            
            Spacer()
        }
    }
}

struct WeekFocus {
    var monday: Int16 = 0
    var tuesday: Int16 = 0
    var wednesday: Int16 = 0
    var thursday: Int16 = 0
    var friday: Int16 = 0
    var saturday: Int16 = 0
    var sunday: Int16 = 0

    var total: Int16 {
        return monday + tuesday + wednesday + thursday + friday + saturday + sunday
    }

    mutating func add(date: Date, count: Int16) {
        let day = Calendar.calendar().component(.weekday, from: date)
        switch day {
            case 1:
                self.sunday += count
            case 2:
                self.monday += count
            case 3:
                self.tuesday += count
            case 4:
                self.wednesday += count
            case 5:
                self.thursday += count
            case 6:
                self.friday += count
            case 7:
                self.saturday += count
            default:
                self.sunday += 0
        }
    }

    func value(of weekday: WeekDay) -> Int16 {
        switch weekday {
            case .monday:
                return monday
            case .tuesday:
                return tuesday
            case .wednesday:
                return wednesday
            case .thursday:
                return thursday
            case .friday:
                return friday
            case .saturday:
                return saturday
            case .sunday:
                return sunday
        }
    }
}
