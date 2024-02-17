import SwiftUI
import Charts


struct ChartView: View {
    var arrayJumpsRealm: [JumpClassRealm]

    private func setTopMission() -> [String: Int] {
        var missionCounts: [String: Int] = [:]

        for jump in arrayJumpsRealm {
            if let count = missionCounts[jump.mission?.localizedValue ?? ""] {
                missionCounts[jump.mission?.localizedValue ?? ""] = count + 1
            } else {
                missionCounts[jump.mission?.localizedValue ?? ""] = 1
            }
        }

        let topMissions = missionCounts.sorted(by: {
            if $0.value == $1.value {
                return $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending
            }
            return $0.value > $1.value
        }).prefix(5)

        let topMissionsArray: [(String, Int)] = topMissions.map { ($0.key, $0.value) }

        return Dictionary(uniqueKeysWithValues: topMissionsArray)
    }

    var body: some View {
        let topMissions = setTopMission()

        ZStack {
            Chart {
                ForEach(topMissions.sorted(by: { $0.value > $1.value }), id: \.key) { mission, count in
                    BarMark(
                        x: .value("Mission", mission),
                        y: .value("Count", count)
                    )
                }
            }

        }
        .frame(maxHeight: .infinity)
        .foregroundStyle(.green)
    }
}

struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        let jumps: [JumpClassRealm] = []
        return ChartView(arrayJumpsRealm: jumps)
    }
}


#Preview {
    let jumps: [JumpClassRealm] = []
    return ChartView(arrayJumpsRealm: jumps)
}
