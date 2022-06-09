//
//  Names.swift
//  99Names
//
//  Created by Sapar Jumabekov on 27.05.2022.
//

import Foundation

struct Name {
    var number: Int
    var original: String
    var transcription: String
    var translate: String
    var description: String
}

func getTopicNumerationFromTo(id: Int) -> (Int, Int) {
    let count = id + 1
    let firstIndex: Int = 9 * (count - 1) + 1
    let lastIndex: Int = count * 9
    return (firstIndex, lastIndex)
}

// 99 имён Аллаха
var AllNames: [Name] = []

func UpdateNames() {
    AllNames = [
        .init(
            number: 1,
            original: "name_original_1".localized,
            transcription: "name_transcription_1".localized,
            translate: "name_translate_1".localized,
            description: "name_description_1".localized
        ),
        .init(
            number: 2,
            original: "name_original_2".localized,
            transcription: "name_transcription_2".localized,
            translate: "name_translate_2".localized,
            description: "name_description_2".localized
        ),
        .init(
            number: 3,
            original: "name_original_3".localized,
            transcription: "name_transcription_3".localized,
            translate: "name_translate_3".localized,
            description: "name_description_3".localized
        ),
        .init(
            number: 4,
            original: "name_original_4".localized,
            transcription: "name_transcription_4".localized,
            translate: "name_translate_4".localized,
            description: "name_description_4".localized
        ),
        .init(
            number: 5,
            original: "name_original_5".localized,
            transcription: "name_transcription_5".localized,
            translate: "name_translate_5".localized,
            description: "name_description_5".localized
        ),
        .init(
            number: 6,
            original: "name_original_6".localized,
            transcription: "name_transcription_6".localized,
            translate: "name_translate_6".localized,
            description: "name_description_6".localized
        ),
        .init(
            number: 7,
            original: "name_original_7".localized,
            transcription: "name_transcription_7".localized,
            translate: "name_translate_7".localized,
            description: "name_description_7".localized
        ),
        .init(
            number: 8,
            original: "name_original_8".localized,
            transcription: "name_transcription_8".localized,
            translate: "name_translate_8".localized,
            description: "name_description_8".localized
        ),
        .init(
            number: 9,
            original: "name_original_9".localized,
            transcription: "name_transcription_9".localized,
            translate: "name_translate_9".localized,
            description: "name_description_9".localized
        ),
        .init(
            number: 10,
            original: "name_original_10".localized,
            transcription: "name_transcription_10".localized,
            translate: "name_translate_10".localized,
            description: "name_description_10".localized
        ),
        .init(
            number: 11,
            original: "name_original_11".localized,
            transcription: "name_transcription_11".localized,
            translate: "name_translate_11".localized,
            description: "name_description_11".localized
        ),
        .init(
            number: 12,
            original: "name_original_12".localized,
            transcription: "name_transcription_12".localized,
            translate: "name_translate_12".localized,
            description: "name_description_12".localized
        ),
        .init(
            number: 13,
            original: "name_original_13".localized,
            transcription: "name_transcription_13".localized,
            translate: "name_translate_13".localized,
            description: "name_description_13".localized
        ),
        .init(
            number: 14,
            original: "name_original_14".localized,
            transcription: "name_transcription_14".localized,
            translate: "name_translate_14".localized,
            description: "name_description_14".localized
        ),
        .init(
            number: 15,
            original: "name_original_15".localized,
            transcription: "name_transcription_15".localized,
            translate: "name_translate_15".localized,
            description: "name_description_15".localized
        ),
        .init(
            number: 16,
            original: "name_original_16".localized,
            transcription: "name_transcription_16".localized,
            translate: "name_translate_16".localized,
            description: "name_description_16".localized
        ),
        .init(
            number: 17,
            original: "name_original_17".localized,
            transcription: "name_transcription_17".localized,
            translate: "name_translate_17".localized,
            description: "name_description_17".localized
        ),
        .init(
            number: 18,
            original: "name_original_18".localized,
            transcription: "name_transcription_18".localized,
            translate: "name_translate_18".localized,
            description: "name_description_18".localized
        ),
        .init(
            number: 19,
            original: "name_original_19".localized,
            transcription: "name_transcription_19".localized,
            translate: "name_translate_19".localized,
            description: "name_description_19".localized
        ),
        .init(
            number: 20,
            original: "name_original_20".localized,
            transcription: "name_transcription_20".localized,
            translate: "name_translate_20".localized,
            description: "name_description_20".localized
        ),
        .init(
            number: 21,
            original: "name_original_21".localized,
            transcription: "name_transcription_21".localized,
            translate: "name_translate_21".localized,
            description: "name_description_21".localized
        ),
        .init(
            number: 22,
            original: "name_original_22".localized,
            transcription: "name_transcription_22".localized,
            translate: "name_translate_22".localized,
            description: "name_description_22".localized
        ),
        .init(
            number: 23,
            original: "name_original_23".localized,
            transcription: "name_transcription_23".localized,
            translate: "name_translate_23".localized,
            description: "name_description_23".localized
        ),
        .init(
            number: 24,
            original: "name_original_24".localized,
            transcription: "name_transcription_24".localized,
            translate: "name_translate_24".localized,
            description: "name_description_24".localized
        ),
        .init(
            number: 25,
            original: "name_original_25".localized,
            transcription: "name_transcription_25".localized,
            translate: "name_translate_25".localized,
            description: "name_description_25".localized
        ),
        .init(
            number: 26,
            original: "name_original_26".localized,
            transcription: "name_transcription_26".localized,
            translate: "name_translate_26".localized,
            description: "name_description_26".localized
        ),
        .init(
            number: 27,
            original: "name_original_27".localized,
            transcription: "name_transcription_27".localized,
            translate: "name_translate_27".localized,
            description: "name_description_27".localized
        ),
        .init(
            number: 28,
            original: "name_original_28".localized,
            transcription: "name_transcription_28".localized,
            translate: "name_translate_28".localized,
            description: "name_description_28".localized
        ),
        .init(
            number: 29,
            original: "name_original_29".localized,
            transcription: "name_transcription_29".localized,
            translate: "name_translate_29".localized,
            description: "name_description_29".localized
        ),
        .init(
            number: 30,
            original: "name_original_30".localized,
            transcription: "name_transcription_30".localized,
            translate: "name_translate_30".localized,
            description: "name_description_30".localized
        ),
        .init(
            number: 31,
            original: "name_original_31".localized,
            transcription: "name_transcription_31".localized,
            translate: "name_translate_31".localized,
            description: "name_description_31".localized
        ),
        .init(
            number: 32,
            original: "name_original_32".localized,
            transcription: "name_transcription_32".localized,
            translate: "name_translate_32".localized,
            description: "name_description_32".localized
        ),
        .init(
            number: 33,
            original: "name_original_33".localized,
            transcription: "name_transcription_33".localized,
            translate: "name_translate_33".localized,
            description: "name_description_33".localized
        ),
        .init(
            number: 34,
            original: "name_original_34".localized,
            transcription: "name_transcription_34".localized,
            translate: "name_translate_34".localized,
            description: "name_description_34".localized
        ),
        .init(
            number: 35,
            original: "name_original_35".localized,
            transcription: "name_transcription_35".localized,
            translate: "name_translate_35".localized,
            description: "name_description_35".localized
        ),
        .init(
            number: 36,
            original: "name_original_36".localized,
            transcription: "name_transcription_36".localized,
            translate: "name_translate_36".localized,
            description: "name_description_36".localized
        ),
        .init(
            number: 37,
            original: "name_original_37".localized,
            transcription: "name_transcription_37".localized,
            translate: "name_translate_37".localized,
            description: "name_description_37".localized
        ),
        .init(
            number: 38,
            original: "name_original_38".localized,
            transcription: "name_transcription_38".localized,
            translate: "name_translate_38".localized,
            description: "name_description_38".localized
        ),
        .init(
            number: 39,
            original: "name_original_39".localized,
            transcription: "name_transcription_39".localized,
            translate: "name_translate_39".localized,
            description: "name_description_39".localized
        ),
        .init(
            number: 40,
            original: "name_original_40".localized,
            transcription: "name_transcription_40".localized,
            translate: "name_translate_40".localized,
            description: "name_description_40".localized
        ),
        .init(
            number: 41,
            original: "name_original_41".localized,
            transcription: "name_transcription_41".localized,
            translate: "name_translate_41".localized,
            description: "name_description_41".localized
        ),
        .init(
            number: 42,
            original: "name_original_42".localized,
            transcription: "name_transcription_42".localized,
            translate: "name_translate_42".localized,
            description: "name_description_42".localized
        ),
        .init(
            number: 43,
            original: "name_original_43".localized,
            transcription: "name_transcription_43".localized,
            translate: "name_translate_43".localized,
            description: "name_description_43".localized
        ),
        .init(
            number: 44,
            original: "name_original_44".localized,
            transcription: "name_transcription_44".localized,
            translate: "name_translate_44".localized,
            description: "name_description_44".localized
        ),
        .init(
            number: 45,
            original: "name_original_45".localized,
            transcription: "name_transcription_45".localized,
            translate: "name_translate_45".localized,
            description: "name_description_45".localized
        ),
        .init(
            number: 46,
            original: "name_original_46".localized,
            transcription: "name_transcription_46".localized,
            translate: "name_translate_46".localized,
            description: "name_description_46".localized
        ),
        .init(
            number: 47,
            original: "name_original_47".localized,
            transcription: "name_transcription_47".localized,
            translate: "name_translate_47".localized,
            description: "name_description_47".localized
        ),
        .init(
            number: 48,
            original: "name_original_48".localized,
            transcription: "name_transcription_48".localized,
            translate: "name_translate_48".localized,
            description: "name_description_48".localized
        ),
        .init(
            number: 49,
            original: "name_original_49".localized,
            transcription: "name_transcription_49".localized,
            translate: "name_translate_49".localized,
            description: "name_description_49".localized
        ),
        .init(
            number: 50,
            original: "name_original_50".localized,
            transcription: "name_transcription_50".localized,
            translate: "name_translate_50".localized,
            description: "name_description_50".localized
        ),
        .init(
            number: 51,
            original: "name_original_51".localized,
            transcription: "name_transcription_51".localized,
            translate: "name_translate_51".localized,
            description: "name_description_51".localized
        ),
        .init(
            number: 52,
            original: "name_original_52".localized,
            transcription: "name_transcription_52".localized,
            translate: "name_translate_52".localized,
            description: "name_description_52".localized
        ),
        .init(
            number: 53,
            original: "name_original_53".localized,
            transcription: "name_transcription_53".localized,
            translate: "name_translate_53".localized,
            description: "name_description_53".localized
        ),
        .init(
            number: 54,
            original: "name_original_54".localized,
            transcription: "name_transcription_54".localized,
            translate: "name_translate_54".localized,
            description: "name_description_54".localized
        ),
        .init(
            number: 55,
            original: "name_original_55".localized,
            transcription: "name_transcription_55".localized,
            translate: "name_translate_55".localized,
            description: "name_description_55".localized
        ),
        .init(
            number: 56,
            original: "name_original_56".localized,
            transcription: "name_transcription_56".localized,
            translate: "name_translate_56".localized,
            description: "name_description_56".localized
        ),
        .init(
            number: 57,
            original: "name_original_57".localized,
            transcription: "name_transcription_57".localized,
            translate: "name_translate_57".localized,
            description: "name_description_57".localized
        ),
        .init(
            number: 58,
            original: "name_original_58".localized,
            transcription: "name_transcription_58".localized,
            translate: "name_translate_58".localized,
            description: "name_description_58".localized
        ),
        .init(
            number: 59,
            original: "name_original_59".localized,
            transcription: "name_transcription_59".localized,
            translate: "name_translate_59".localized,
            description: "name_description_59".localized
        ),
        .init(
            number: 60,
            original: "name_original_60".localized,
            transcription: "name_transcription_60".localized,
            translate: "name_translate_60".localized,
            description: "name_description_60".localized
        ),
        .init(
            number: 61,
            original: "name_original_61".localized,
            transcription: "name_transcription_61".localized,
            translate: "name_translate_61".localized,
            description: "name_description_61".localized
        ),
        .init(
            number: 62,
            original: "name_original_62".localized,
            transcription: "name_transcription_62".localized,
            translate: "name_translate_62".localized,
            description: "name_description_62".localized
        ),
        .init(
            number: 63,
            original: "name_original_63".localized,
            transcription: "name_transcription_63".localized,
            translate: "name_translate_63".localized,
            description: "name_description_63".localized
        ),
        .init(
            number: 64,
            original: "name_original_64".localized,
            transcription: "name_transcription_64".localized,
            translate: "name_translate_64".localized,
            description: "name_description_64".localized
        ),
        .init(
            number: 65,
            original: "name_original_65".localized,
            transcription: "name_transcription_65".localized,
            translate: "name_translate_65".localized,
            description: "name_description_65".localized
        ),
        .init(
            number: 66,
            original: "name_original_66".localized,
            transcription: "name_transcription_66".localized,
            translate: "name_translate_66".localized,
            description: "name_description_66".localized
        ),
        .init(
            number: 67,
            original: "name_original_67".localized,
            transcription: "name_transcription_67".localized,
            translate: "name_translate_67".localized,
            description: "name_description_67".localized
        ),
        .init(
            number: 68,
            original: "name_original_68".localized,
            transcription: "name_transcription_68".localized,
            translate: "name_translate_68".localized,
            description: "name_description_68".localized
        ),
        .init(
            number: 69,
            original: "name_original_69".localized,
            transcription: "name_transcription_69".localized,
            translate: "name_translate_69".localized,
            description: "name_description_69".localized
        ),
        .init(
            number: 70,
            original: "name_original_70".localized,
            transcription: "name_transcription_70".localized,
            translate: "name_translate_70".localized,
            description: "name_description_70".localized
        ),
        .init(
            number: 71,
            original: "name_original_71".localized,
            transcription: "name_transcription_71".localized,
            translate: "name_translate_71".localized,
            description: "name_description_71".localized
        ),
        .init(
            number: 72,
            original: "name_original_72".localized,
            transcription: "name_transcription_72".localized,
            translate: "name_translate_72".localized,
            description: "name_description_72".localized
        ),
        .init(
            number: 73,
            original: "name_original_73".localized,
            transcription: "name_transcription_73".localized,
            translate: "name_translate_73".localized,
            description: "name_description_73".localized
        ),
        .init(
            number: 74,
            original: "name_original_74".localized,
            transcription: "name_transcription_74".localized,
            translate: "name_translate_74".localized,
            description: "name_description_74".localized
        ),
        .init(
            number: 75,
            original: "name_original_75".localized,
            transcription: "name_transcription_75".localized,
            translate: "name_translate_75".localized,
            description: "name_description_75".localized
        ),
        .init(
            number: 76,
            original: "name_original_76".localized,
            transcription: "name_transcription_76".localized,
            translate: "name_translate_76".localized,
            description: "name_description_76".localized
        ),
        .init(
            number: 77,
            original: "name_original_77".localized,
            transcription: "name_transcription_77".localized,
            translate: "name_translate_77".localized,
            description: "name_description_77".localized
        ),
        .init(
            number: 78,
            original: "name_original_78".localized,
            transcription: "name_transcription_78".localized,
            translate: "name_translate_78".localized,
            description: "name_description_78".localized
        ),
        .init(
            number: 79,
            original: "name_original_79".localized,
            transcription: "name_transcription_79".localized,
            translate: "name_translate_79".localized,
            description: "name_description_79".localized
        ),
        .init(
            number: 80,
            original: "name_original_80".localized,
            transcription: "name_transcription_80".localized,
            translate: "name_translate_80".localized,
            description: "name_description_80".localized
        ),
        .init(
            number: 81,
            original: "name_original_81".localized,
            transcription: "name_transcription_81".localized,
            translate: "name_translate_81".localized,
            description: "name_description_81".localized
        ),
        .init(
            number: 82,
            original: "name_original_82".localized,
            transcription: "name_transcription_82".localized,
            translate: "name_translate_82".localized,
            description: "name_description_82".localized
        ),
        .init(
            number: 83,
            original: "name_original_83".localized,
            transcription: "name_transcription_83".localized,
            translate: "name_translate_83".localized,
            description: "name_description_83".localized
        ),
        .init(
            number: 84,
            original: "name_original_84".localized,
            transcription: "name_transcription_84".localized,
            translate: "name_translate_84".localized,
            description: "name_description_84".localized
        ),
        .init(
            number: 85,
            original: "name_original_85".localized,
            transcription: "name_transcription_85".localized,
            translate: "name_translate_85".localized,
            description: "name_description_85".localized
        ),
        .init(
            number: 86,
            original: "name_original_86".localized,
            transcription: "name_transcription_86".localized,
            translate: "name_translate_86".localized,
            description: "name_description_86".localized
        ),
        .init(
            number: 87,
            original: "name_original_87".localized,
            transcription: "name_transcription_87".localized,
            translate: "name_translate_87".localized,
            description: "name_description_87".localized
        ),
        .init(
            number: 88,
            original: "name_original_88".localized,
            transcription: "name_transcription_88".localized,
            translate: "name_translate_88".localized,
            description: "name_description_88".localized
        ),
        .init(
            number: 89,
            original: "name_original_89".localized,
            transcription: "name_transcription_89".localized,
            translate: "name_translate_89".localized,
            description: "name_description_89".localized
        ),
        .init(
            number: 90,
            original: "name_original_90".localized,
            transcription: "name_transcription_90".localized,
            translate: "name_translate_90".localized,
            description: "name_description_90".localized
        ),
        .init(
            number: 91,
            original: "name_original_91".localized,
            transcription: "name_transcription_91".localized,
            translate: "name_translate_91".localized,
            description: "name_description_91".localized
        ),
        .init(
            number: 92,
            original: "name_original_92".localized,
            transcription: "name_transcription_92".localized,
            translate: "name_translate_92".localized,
            description: "name_description_92".localized
        ),
        .init(
            number: 93,
            original: "name_original_93".localized,
            transcription: "name_transcription_93".localized,
            translate: "name_translate_93".localized,
            description: "name_description_93".localized
        ),
        .init(
            number: 94,
            original: "name_original_94".localized,
            transcription: "name_transcription_94".localized,
            translate: "name_translate_94".localized,
            description: "name_description_94".localized
        ),
        .init(
            number: 95,
            original: "name_original_95".localized,
            transcription: "name_transcription_95".localized,
            translate: "name_translate_95".localized,
            description: "name_description_95".localized
        ),
        .init(
            number: 96,
            original: "name_original_96".localized,
            transcription: "name_transcription_96".localized,
            translate: "name_translate_96".localized,
            description: "name_description_96".localized
        ),
        .init(
            number: 97,
            original: "name_original_97".localized,
            transcription: "name_transcription_97".localized,
            translate: "name_translate_97".localized,
            description: "name_description_97".localized
        ),
        .init(
            number: 98,
            original: "name_original_98".localized,
            transcription: "name_transcription_98".localized,
            translate: "name_translate_98".localized,
            description: "name_description_98".localized
        ),
        .init(
            number: 99,
            original: "name_original_99".localized,
            transcription: "name_transcription_99".localized,
            translate: "name_translate_99".localized,
            description: "name_description_99".localized
        )
    ]
}
