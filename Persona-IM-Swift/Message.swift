//
//  Message.swift
//  Persona-IM-Swift
//  
//  Created by shsw228 on 2024/09/13
//

import Foundation
import SwiftUI

struct Message: Equatable, Hashable {
    let sender: Sender
    let text: String
}

enum Sender {
    case Ann
    case Ryuji
    case Yusuke
    case Ren

    func image() -> ImageResource?{
        switch self {
        case .Ann:
            ImageResource.Icon.ann
        case .Ryuji:
            ImageResource.Icon.ryuji
        case .Yusuke:
            ImageResource.Icon.yusuke
        case .Ren:
            nil
        }
    }
    func color() -> Color {
        switch self {
        case .Ann:
            Color(ColorResource.Color.ann)
        case .Ryuji:
            Color(ColorResource.Color.ryuji)
        case .Yusuke:
            Color(ColorResource.Color.yusuke)
        case .Ren:
            Color.clear
        }
    }

}

class MessagesState {
    private var count = 0

    func advance() -> [Message] {
        count += 1
        if count > Messages.count {
            count = 1
        }
        return Messages.prefix(count).map { $0 }
    }
    let Messages: [Message] = [
        Message(
            sender:Sender.Ann,
            text:"What are we doing today?"
        ),
        Message(
            sender:Sender.Ann,
            text:"We have to find them tomorrow for sure. This is the only lead we have right now."
        ),
        Message(
            sender:Sender.Yusuke,
            text:"Yes. It is highly likely that this part-time solicitor is somehow related to the mafia."
        ),
        Message(
            sender:Sender.Yusuke,
            text:"If we tail him, he may lead us straight back to his boss."
        ),
        Message(
            sender:Sender.Ryuji,
            text:"He talked to Iida and Nishiyama over at Central Street, right?"
        ),
        Message(
            sender:Sender.Yusuke,
            text:"Indeed, it seems that is where our target waits. But then... who should be the one to go?"
        ),
        Message(
            sender:Sender.Ren,
            text:"Morgana, I choose you. Morgana, I choose you.Morgana, I choose you."
        ),
        Message(
            sender:Sender.Ann,
            text:"That's not a bad idea. Cats have nine lives, right? Morgana can spare one for this."
        ),
        Message(
            sender:Sender.Ryuji,
            text:"Wouldn't the mafia get caught off guard if they had a cat coming to deliver for 'em?"
        ),
        Message(
            sender:Sender.Yusuke,
            text:"In other words, Maaku will be going. I have no objections."
        ),
        Message(
            sender:Sender.Yusuke,
            text:"Tricking people and using that as blackmail… These bastards are true cowards."
        ),
        Message(
            sender:Sender.Ann,
            text:"It’s kinda scary to think people like that are all around us in this city..."
        ),
        Message(
            sender:Sender.Ryuji,
            text:"Well guys, we gotta brace ourselves. We’re up against a serious criminal here."
        ),
    ]

}
