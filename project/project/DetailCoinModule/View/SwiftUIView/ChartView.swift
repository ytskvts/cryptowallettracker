//
//  ChartView.swift
//  project
//
//  Created by Dzmitry on 22.02.22.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinTableViewCellViewModel) {
        data = coin.sparklineIn7D?.price ?? []
//        data = coin.sparklineIn7D?.price ?? [40727.15894467075,40767.313152896866,40711.90199563559,40868.21271577652,40948.40751726504,40895.15573617572,40303.28345704476,40499.48058744105,40477.73809869106,40375.74437287891,39868.32856312466,40237.83337042184,40104.804279566735,40205.12145578267,40258.11567800297,40054.62963249416,40093.41532533004,40039.00123905567,40073.495362369824,40270.39863528418,40219.04099191778,40235.82127166268,40199.10907883189,40243.34178505652,40289.25829858139,40442.26136646485,40326.37457316245,40131.0056917863,40018.858461061376,40002.109729539065,39834.7316979947,39822.31852414107,40105.33149776008,39976.56983170297,40027.77337408034,40097.98909144113,40186.10984776536,40170.687432676044,40022.60966573471,40114.552838158306,39971.17100461406,40102.312135675,40192.75912143141,39992.471182825575,40076.07980101857,39951.3617593317,39863.20024318449,39665.03629865012,39523.2465871302,38895.42993870602,38896.334892016675,38366.65964209072,38279.21427896171,38337.449887395465,38396.29950412052,38344.91182550849,38356.08351805149,38263.04661007489,38432.273401771985,38408.46223258379,38377.0864925322,38508.69617978726,38485.90512251745,38415.44417874599,38277.78283135466,38779.673226740204,38514.00853622455,38698.143866857215,39333.43065115193,39244.9948726459,39012.36396744542,39424.08816499685,39326.81155698784,39288.01594225328,39372.53553503632,39377.76505610018,39184.5169911131,39025.18722040988,38416.51587510028,37638.76775388263,37557.60015885126,37627.66879304153,38864.916808228394,38867.05638356442,38908.761852576186,38659.664933164146,37906.35477220734,38247.02012890013,38309.05444726724,37581.38981158203,37682.44208849052,37059.979402287514,37280.91362125845,37345.7173827951,37106.70811113305,36629.4710428159,36697.862052822114,36912.05210149528,36885.077192002616,36950.83280724751,37109.32788384755,37258.487906496,37787.25844519545,37655.42950613923,37695.649935479494,37884.003504374574,38123.747274648515,37856.479107140505,37708.02331427248,37722.24583807338,37803.36055948003,38151.682093193966,37983.70577637663,37977.09884017937,37939.20636557496,38337.2038554348,38219.53225610303,38096.21251300756,37715.60461960694,37825.96287250244,38060.31778962817,38054.609385412674,38043.87834379807,38198.63340703107,38727.3866855343,38967.23500717916,38908.84782751134,38881.90197586524,39069.82840245467,39039.75637622227,38806.50011453167,38594.36698776396,38752.51291568798,38242.43334687232,37848.229207406075,37714.17215683679,37747.86212839062,37583.890059417005,37710.85420188049,37372.2926803477,36889.77499712784,37043.405125056815,36694.076166224695,35159.930580253764,35166.95275976058,34740.0118751087,34987.41736860001,35208.87146190525,35619.26291060089,35468.222735858835,35270.79457760816,35496.406543163175,35320.60286399167,35694.05825136191,35728.885048502496,35932.01387000279,36154.56017283712,35945.724927709874,36535.98323155821,37214.89569796503,38457.728870905565,38468.39903563178,37893.43965898341,38363.345488570165,38388.99675609016,38535.83977552898,38798.10871043605,38879.139220865065,38816.99222598338]
        //print("coinData: \(coin)")
        //print("grapgh \(data)")
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
