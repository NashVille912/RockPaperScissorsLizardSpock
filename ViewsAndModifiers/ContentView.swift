//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Nacho on 06/02/2024.
//

import SwiftUI

struct ContentView: View {
    
	struct ClipText:  View {
		var text: String
		
		var body: some View{
			Text(text)
				.font(.largeTitle)
				.padding()
				.frame(width: 90, height: 90)
				.background(Color.orange).opacity(0.8)
				.clipShape(Circle())
			
		}
		
	}
	
	let options: [String] = ["Rock", "Scissors", "Paper", "Lizard", "Spock"]
	@State private var playerScore = 0
	@State private var opponentScore = 0
	@State private var showResult = false
	@State private var restartGame = false
	@State private var winner = ""
	
	var body: some View {
		VStack{
			Text("Rock - Paper - Scissors - Lizard - Spock")
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(.white).opacity(0.9)
				.padding(.top, 40)
				.multilineTextAlignment(.center)
			
			Spacer()
			
			Text("Select One")
				.font(.headline)
				.foregroundColor(.white)
				.padding(.bottom)
			
			VStack {
				HStack {
					Button {
						winner = playGame(playerOption: "Rock")
					} label: {
						ClipText(text: "🪨")
					}
					Button {
						winner = playGame(playerOption: "Scissors")
					} label: {
						ClipText(text: "✂️")
					}
					Button {
						winner = playGame(playerOption: "Paper")
					} label: {
						ClipText(text: "📃")
					}
				}
				HStack{
					Button {
						winner = playGame(playerOption: "Lizard")
					} label: {
						ClipText(text: "🦎")
					}
					Button {
						winner = playGame(playerOption: "Spock")
					} label: {
						ClipText(text: "🖖🏻")
					}
				}
			}
			.padding(.bottom, 20)
			
			HStack(spacing: 20){
				Text("Player 1: \(playerScore)")
				Text("Opponent: \(opponentScore)")
			}
			.font(.title2)
			.fontWeight(.bold)
			.foregroundColor(.white).opacity(0.9)
			
			Spacer()
			
			Button {
				if playerScore != 0 || opponentScore != 0 {
					resetGame()
				} else {
					return
				}
			} label: {
				Text("Reset")
					.font(.title3)
					.foregroundColor(.white)
					.frame(width: 80, height: 80)
					.background(Color.orange).opacity(0.8)
					.clipShape(Circle())
			}.padding(.bottom, 30)
		}
		.alert(winner != "Tie" ? "Winner: \(winner)" : "It's a Tie", isPresented: $showResult, actions: {})
		.alert("Game Restarted", isPresented: $restartGame, actions: {})
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color(red: 0.6, green: 0.3, blue: 0.9))
	}
	
	func playGame(playerOption: String) -> String {
			let computer = computerOption()
			showResult.toggle()
		
			print("Player: \(playerOption)")
			print("Computer: \(computer)")
			
			if playerOption == computer {
				return "Tie"
			}
			else if (playerOption == "Rock" && computer == "Scissors") ||
					(playerOption == "Rock" && computer == "Lizard") ||
					(playerOption == "Scissors" && computer == "Paper") ||
					(playerOption == "Scissors" && computer == "Lizard") ||
					(playerOption == "Paper" && computer == "Rock") ||
					(playerOption == "Paper" && computer == "Spock") ||
					(playerOption == "Spock" && computer == "Rock") ||
					(playerOption == "Spock" && computer == "Scissors") ||
					(playerOption == "Lizard" && computer == "Spock") ||
					(playerOption == "Lizard" && computer == "Paper"){
				playerScore += 1
				return "Player"
			} else {
				opponentScore += 1
				return "Opponent"
			}
	}
	
	func computerOption() -> String{
		let randomNumber = Int.random(in: 0...2)
		let opponentOption = options[randomNumber]
		return opponentOption
	}
	
	func resetGame() {
		playerScore = 0
		opponentScore = 0
		restartGame.toggle()
		
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
