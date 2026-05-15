enum TrainType: String {
    case ktx = "KTX"
    case ktxSancheon = "KTX-산천"
    case itxSaemaeul = "ITX-새마을"
    case mugunghwa = "무궁화호"

    var title: String {
        rawValue
    }
}
