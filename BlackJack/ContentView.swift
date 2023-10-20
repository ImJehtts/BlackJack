//
//  ContentView.swift
//  BlackJack
//
//  Created by Mohib Rehman on 2023-06-21.
//

import SwiftUI

struct ContentView: View {

    //Cards of play
    @State var playercards = ["","","","",""]
    @State var playersplitcards = ["","","","",""]
    @State var dealercards = ["","","","",""]
    @State var suits = ["clubs","diamonds","hearts","spades"]
    @State var dealerfirstcard = ""
    @State var dealerfirstcard_value = 0
    //
    
    //Betting variables
    @State var Chips = 3000
    @State var current_bet = 0
    @State var last_bet = 0
    @State var bets = [Int]()
    @State var beting_allowed = true
    @State var min_bet_placed = false
    @State var cant_minus = false
    @State var cant_plus = false
    @State var biggest_win = 0
    @State var double_split_bet = 0
    //
    
    //Dealing Cards
    @State var playerhand_score = 0
    @State var dealerhand_score = 0
    @State var playerhandsplit_score = 0
    @State var playercards_dealt = 0
    @State var playercardssplit_dealt = 0
    @State var dealercards_dealt = 0
    @State var can_hit = false
    @State var can_stand = false
    @State var can_double = false
    @State var can_split = false
    
    @State var playerhave_ace = false
    @State var playerhave_splitace = false
    @State var dealerhave_ace = false
    @State var dealerdone = false
    @State var dealerbust = false
    @State var end_game = false
    @State var end_game_reason = ""
    @State var end_game_message = ""

    @State var player_first_card = 0
    @State var player_second_card = 0
    @State var split_hand1 = Color.white
    @State var split_hand2 = Color.white
    //
    
    
    var body: some View {
        
        ZStack{
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea()
        
            VStack{
                HStack{
                    Spacer()
                    Text("Chips")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 35.0)
                }
                HStack{
                    Spacer()
                        Text(String(Chips))
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 15.0)
                            .background(Rectangle().foregroundColor(.purple))
                            .cornerRadius(25)
                }
                VStack{
                    Text("Dealer's Hand: " + String(dealerhand_score))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.top, 2.0)
                    Spacer()
                    
                    //Dealercards
                    HStack{
                        Spacer()
                        Image(dealercards[0]).resizable().aspectRatio(contentMode: .fit)
                        Image(dealercards[1]).resizable().aspectRatio(contentMode: .fit)
                        Image(dealercards[2]).resizable().aspectRatio(contentMode: .fit)
                        Image(dealercards[3]).resizable().aspectRatio(contentMode: .fit)
                        Image(dealercards[4]).resizable().aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                }
                VStack{
                    HStack{
                        Spacer()
                        Text("Player's Hand:")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Text(String(playerhand_score))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(split_hand1)
                        Text(".")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Text(String(playerhandsplit_score))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(split_hand2)
                        Spacer()
                    }
                    
                    //Playercards
                    HStack{
                        Spacer()
                        Image(playercards[0]).resizable().aspectRatio(contentMode: .fit)
                        Image(playercards[1]).resizable().aspectRatio(contentMode: .fit)
                        Image(playercards[2]).resizable().aspectRatio(contentMode: .fit)
                        Image(playercards[3]).resizable().aspectRatio(contentMode: .fit)
                        Image(playercards[4]).resizable().aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                }
                HStack{
                    Spacer()
                    Image(playersplitcards[0]).resizable().aspectRatio(contentMode: .fit)
                    Image(playersplitcards[1]).resizable().aspectRatio(contentMode: .fit)
                    Image(playersplitcards[2]).resizable().aspectRatio(contentMode: .fit)
                    Image(playersplitcards[3]).resizable().aspectRatio(contentMode: .fit)
                    Image(playersplitcards[4]).resizable().aspectRatio(contentMode: .fit)
                    Spacer()
                }
                
                //HStack for all betting chips and actions of play
                HStack{
                    Spacer()
                    Button{
                        fiftybutton()
                    }label:{
                        Image("poker_50")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.disabled(beting_allowed == false)
                    
                    Button{
                        hundredbutton()
                    }label:{
                        Image("poker_100")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.disabled(beting_allowed == false)
                    
                    Button{
                        two_hundredbutton()
                    }label:{
                        Image("poker_200")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                    }.disabled(beting_allowed == false)
                    
                    Button{
                        five_hundredbutton()
                    }label:{
                        Image("poker_500")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.disabled(beting_allowed == false)
                    
                    Button{
                        thousandbutton()
                    }label:{
                        Image("poker_1000")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } .disabled(beting_allowed == false)
                    
                    Spacer()
                    
                }
                HStack{
                    Spacer()
                    Button{
                        minusbutton()
                    }label:{
                        Image("poker_minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:50.0, height:45.0)
                    } .disabled(beting_allowed == false)
                        .alert(isPresented:$cant_minus){
                            Alert(title: Text("You dont have any bets to subtract"),message: Text("This button takes your bets away from the pot one by one."), dismissButton: .default(Text("Ok")))
                        }

                        Text(String(current_bet))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 15.0)
                            .background(Rectangle().foregroundColor(.purple))
                            .cornerRadius(10)
                    Button{
                        plusbutton()
                    }label:{
                        Image("poker_plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:50.0, height:45.0)
                    } .disabled(beting_allowed == false)
                        .alert(isPresented: $cant_plus){
                            Alert(title: Text("You dont have enough money"),message: Text("This button adds double your most recent bet to the pot. Can be stacked."), dismissButton: .default(Text("Ok")))
                        }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Button{
                        bet_made()
                    }label:{
                        Text("Bet")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 20.0)
                            .background(Rectangle().foregroundColor(.teal))
                            .cornerRadius(15)
                    }.disabled(min_bet_placed == false)
                        .alert(isPresented: $end_game){
                            Alert(title: Text(end_game_reason),message: Text("\(end_game_message)"))
                    }
                        
                    Spacer()
                }
                
                //Vstack for actions of play
              Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Button{
                            hit()
                        }label:{
                            Text("Hit")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 40.0)
                                .background(Rectangle().foregroundColor(.orange))
                                .cornerRadius(30)
                        }.disabled(can_hit == false)
                        
                        Spacer()
                        Button{
                            double()
                        }label:{
                            Text("Double")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 15.0)
                                .background(Rectangle().foregroundColor(.orange))
                                .cornerRadius(30)
                        }.disabled(can_double == false)
                        
                        Spacer()
                    }
                    Spacer()
                    VStack{
                        Spacer()
                        Button{
                            stand()
                        }label:{
                            Text("Stand")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 20.0)
                                .background(Rectangle().foregroundColor(.orange))
                                .cornerRadius(30)
                        }.disabled(can_stand == false)
                        
                        Spacer()
                        Button{
                            split()
                        }label:{
                            Text("Split")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 30.0)
                                .background(Rectangle().foregroundColor(.orange))
                                .cornerRadius(30)
                        }.disabled(can_split == false)
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    //Betting chip functios
    func fiftybutton(){
        if Chips - 50 >= 0{
            current_bet += 50
            Chips -= 50
            bets.append(50)
            min_bet_placed = true
        }
    }
    func hundredbutton(){
        if Chips - 100 >= 0{
            current_bet += 100
            Chips -= 100
            bets.append(100)
            min_bet_placed = true
        }
    }
    func two_hundredbutton(){
        if Chips - 200 >= 0{
            current_bet += 200
            Chips -= 200
            bets.append(200)
            min_bet_placed = true
        }
    }
    func five_hundredbutton(){
        if Chips - 500 >= 0{
            current_bet += 500
            Chips -= 500
            bets.append(500)
            min_bet_placed = true
        }
    }
    func thousandbutton(){
        if Chips - 1000 >= 0{
            current_bet += 1000
            Chips -= 1000
            bets.append(1000)
            min_bet_placed = true
        }
    }
    func minusbutton(){
        if bets.count > 0{
            last_bet = bets.removeLast()
            Chips += last_bet
            current_bet -= last_bet
        }
        else{
            cant_minus = true
        }
    }
    
    func plusbutton(){
        if let last_betplus = bets.last{
            if (Chips - (last_betplus)*2) >= 0{
                current_bet += (last_betplus)*2
                Chips -= (last_betplus)*2
                last_bet = (last_betplus)*2
                bets.append(last_bet)
            }
            else{
                cant_plus = true
            }
        }
    }
    
    //Function for when bet made
    func bet_made(){
        beting_allowed = false
        min_bet_placed = false
        
        for _ in 1...2{
            player_turn()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            var dealerrandom:Int = (Int.random(in: 1...13))
            var suitsrandom:Int = (Int.random(in: 0...3))
            //Variable used at end to see if blackjack for dealer. Cant use score as it messes with the display
            var blkjack_check = 0
            //Deals first card for dealer but keeps it secret
            dealercards[dealercards_dealt] = "back"
            dealercards_dealt += 1
            dealerfirstcard = String(suits[suitsrandom]) + String(dealerrandom)
            dealerfirstcard_value = dealerrandom
            
            if dealerfirstcard_value == 1{
                blkjack_check = 11
            }
            else if dealerfirstcard_value >= 10{
                blkjack_check = 10
            }
            
            dealerrandom = (Int.random(in: 1...13))
            suitsrandom = (Int.random(in: 0...3))
            dealercards[dealercards_dealt] = String(suits[suitsrandom]) + String(dealerrandom)
            dealercards_dealt += 1
            if dealerrandom > 1 && dealerrandom < 10{
                dealerhand_score += dealerrandom
            }
            else if dealerrandom >= 10 {
                dealerhand_score += 10
                blkjack_check += 10
            }
            else {
                if (dealerhand_score + 11) <= 21{
                    dealerhand_score += 11
                    dealerhave_ace = true
                    blkjack_check += 11
                }
                else{
                    dealerhand_score += 1
                }
            }
            
            if blkjack_check == 21{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65){
                    //if dealer gets blackjack, player turn is over
                    dealer_turn()
                }
            
            }
            else{
                //If player has enough chips for splits or doubles and the right cards, it is allowed
                if (Chips - (current_bet)) >= 0{
                    can_double = true
                }
                can_hit = true
                can_stand = true
                
                if player_first_card == player_second_card{
                    if (Chips - (current_bet)) >= 0{
                        can_split = true
                    }
                }
                else if (player_first_card == 11) && (player_second_card == 1) || (player_first_card == 1) && (player_second_card == 11){
                    if (Chips - (current_bet)) >= 0{
                        //If player has two aces, split allowed
                        can_split = true
                    }
                }
            }
            if playerhand_score == 21{
                //If player gets blackjack, their turn is over
                dealer_turn()
            }
        }
    }
    
    func hit(){
        //Once hit, can no longer preform these actions
        can_split = false
        can_double = false
        
        //On first hand of split
        if (split_hand1 == Color.red){
                if playercards_dealt <= 5{
                    //max cards check
                    player_turn()
                }
                else{
                    split_hand1 = Color.white
                    split_hand2 = Color.red
                    playersplit2_turn()
                    if playerhandsplit_score >= 21{
                        dealer_turn()
                    }
                }
                
                if playerhand_score >= 21{
                    split_hand1 = Color.white
                    split_hand2 = Color.red
                    playersplit2_turn()
                    if playerhandsplit_score >= 21{
                        dealer_turn()
                    }
                }
        }
        
        //On second hand of split
        else if (split_hand2 == Color.red){
                playersplit2_turn()

            if playerhandsplit_score >= 21{
                dealer_turn()
            }
            else if playercardssplit_dealt >= 5{
                dealer_turn()
            }
        }
        //No split made
        else{
                if playercards_dealt < 5{
                    player_turn()
                }
                if playerhand_score >= 21{
                    dealer_turn()
                }
                if playercards_dealt == 5{
                    dealer_turn()
            }
        }
    }

    func split(){
        can_split = false
        //Second player card becomes first split card
        playersplitcards[0] = playercards[1]
        playercards[1] = ""
        
        //Makes appropriate bet for split
        Chips = Chips - current_bet
        current_bet = (current_bet*2)
        playercards_dealt -= 1
        playercardssplit_dealt += 1
        double_split_bet = (current_bet/2)
        
        split_hand1 = Color.red
        
        //Checks for aces split
        if (player_first_card == 11) && (player_second_card == 1) || (player_first_card == 1) && (player_second_card == 11){
            playerhand_score = 11
            playerhandsplit_score = 11
        }
        else {
            playerhand_score = player_first_card
            playerhandsplit_score = player_second_card
        }
        
        player_turn()
        
        if (Chips - double_split_bet) >= 0{
            can_double = true
        }
        
        if playerhand_score >= 21{
            split_hand1 = Color.white
            split_hand2 = Color.red
            playersplit2_turn()
            if playerhandsplit_score >= 21{
                dealer_turn()
            }
        }
    }
    
    func double(){
        if (split_hand1 == Color.red){
            if (Chips - double_split_bet >= 0){
                Chips = Chips - double_split_bet
                current_bet += double_split_bet
                player_turn()
                //Gives the first hand of the split a double down card and moves onto second hand
                
                split_hand1 = Color.white
                split_hand2 = Color.red
                playersplit2_turn()
            }
        }
        else if (split_hand2 == Color.red){
            if (Chips - double_split_bet >= 0){
                //Gives second hand of split double down card and moves onto dealer
                Chips = Chips - double_split_bet
                current_bet += double_split_bet
                playersplit2_turn()
                dealer_turn()
            }
   
        }
        //No split was made
        else{
            if (Chips - (current_bet)) >= 0{
                Chips = Chips - current_bet
                current_bet = (current_bet*2)
                player_turn()
                dealer_turn()
            }
        }
    }
    
    func stand(){
        if (split_hand1 == Color.red){
            split_hand1 = Color.white
            split_hand2 = Color.red
            playersplit2_turn()
            if playerhandsplit_score >= 21{
                dealer_turn()
            }
            else if playercardssplit_dealt >= 5{
                dealer_turn()
            }
        }
        //If on second hand of split or no split was made, stand is followed by dealer's turn
        else {
            dealer_turn()
        }
    }
    
    func dealer_turn(){
        //Once dealer's turn, player can no longer preform any actions
        can_hit = false
        can_stand = false
        can_split = false
        can_double = false
        
        //Add dealer's first card and it's value to dealer's hand
        dealercards[0] = dealerfirstcard
        
        if dealerfirstcard_value > 1 && dealerfirstcard_value < 10{
            dealerhand_score += dealerfirstcard_value
        }
        else if dealerfirstcard_value >= 10 {
            dealerhand_score += 10
        }
        else {
            if (dealerhand_score + 11) <= 21{
                dealerhand_score += 11
                dealerhave_ace = true
            }
            else{
                dealerhand_score += 1
            }
        }
        
        //If both split player hands bust, game ends
        if playerhand_score > 21 && playerhandsplit_score > 21{
            dealerdone = true
            end_game_lose()
        }
        //If player busts (no split), game ends
        else if playerhand_score > 21 && split_hand2 == Color.white{
            dealerdone = true
            end_game_lose()
        }
        
        //21 20 9
        /////////////////////////
        while (dealerdone == false){
            if dealercards_dealt == 5{
                //dealer has max cards
                dealerdone = true
            }
            else if ((dealerhand_score < playerhand_score) && (dealerhand_score < playerhandsplit_score) && (dealerhand_score < 17) && (playerhand_score <= 21) && (playerhandsplit_score <= 21)) || ((dealerhand_score < playerhand_score) && (dealerhand_score < 17) && (playerhand_score <= 21)) || ((dealerhand_score == playerhand_score) && (dealerhand_score < 17)) || ((dealerhand_score == playerhand_score) && (dealerhand_score == playerhandsplit_score) && (dealerhand_score < 17)) || ((dealerhand_score >= playerhand_score) && (dealerhand_score < playerhandsplit_score) && (dealerhand_score < 17) && (playerhandsplit_score <= 21)) || ((dealerhand_score < playerhand_score) && (dealerhand_score >= playerhandsplit_score) && (dealerhand_score < 17) && (playerhand_score <= 21)){
                //Dealer must hit when under 17 or under the playerhand score
                let dealerrandom:Int = (Int.random(in: 1...13))
                let suitsrandom:Int = (Int.random(in: 0...3))
                dealercards[dealercards_dealt] = String(suits[suitsrandom]) + String(dealerrandom)
                dealercards_dealt += 1
            
                //Value used to adjust aces if dealer has them
                var value_added = 0
                if dealerrandom > 1 && dealerrandom < 10{
                    value_added = dealerrandom
                }
                else if dealerrandom >= 10 {
                    value_added = 10
                }
                else {
                    if (dealerhand_score + 11) <= 21{
                        //if ace is drawn and it can be added as 11 without causing bust, do so. Otherwise it is added as a 1
                        value_added = 11
                        dealerhave_ace = true
                    }
                    else{
                        value_added = 1
                    }
                }
                
                if (dealerhand_score + value_added > 21) && (dealerhave_ace == true){
                    //If dealer has an ace that is currently being stored as an 11, make it a 1 so most recent drawn card can be used
                    dealerhand_score -= 10
                    dealerhave_ace = false
                }
            
            dealerhand_score += value_added
            
            }
            else{
                //Dealer hand is 17+ or has beat the player
                dealerdone = true
            }
        }
        
        if dealerhand_score > 21{
            dealerbust = true
        }
        
        //Checking for all outcomes to the game
        if (split_hand2 == Color.red){
            if (dealerhand_score == playerhand_score) && (dealerhand_score == playerhandsplit_score){
                //Push: #Both hands are equal to dealer
                end_game_reason = "Push"
                end_game_message = "Both hands equal to dealer's hand"
                end_game_push()
            }
            else if ((dealerhand_score < playerhand_score) && (dealerhand_score > playerhandsplit_score) && (dealerbust == false) && (playerhand_score < 21) && (playerhandsplit_score < 21)) || ((dealerhand_score > playerhand_score) && (dealerhand_score < playerhandsplit_score) && (dealerbust == false) && (playerhand_score < 21) && (playerhandsplit_score < 21)){
                //Push: #Hand1 beats dealer and Hand2 loses to dealer, #Hand2 beats dealer and Hand1 loses to dealer
                end_game_reason = "50/50"
                end_game_message = "1 Hand beat the dealer while the other hand lost"
                end_game_push()
            }
            else if ((playerhand_score > 21) && (playerhandsplit_score < 21) && (dealerbust == true)) || ((playerhand_score < 21) && (playerhandsplit_score > 21) && (dealerbust == true)){
                //Push: #Dealer busts and so does Hand1, #Dealer busts and so does Hand2
                end_game_reason = "50/50"
                end_game_message = "1 Hand and the Dealer busted while the other did not"
                end_game_push()
            }
            else if ((dealerhand_score < playerhand_score) && (dealerbust == false) && (playerhandsplit_score > 21) && (playerhand_score < 21)) || ((dealerhand_score < playerhandsplit_score) && (dealerbust == false) && (playerhand_score > 21) && (playerhandsplit_score < 21)){
                //Push: #Hand1 wins and Hand2 busts, #Hand2 wins and Hand1 busts
                end_game_reason = "50/50"
                end_game_message = "1 Hand won and 1 Hand busted"
                end_game_push()
            }
            else if ((dealerhand_score < playerhand_score) && (dealerhand_score < playerhandsplit_score) && (playerhand_score < 21) && (playerhandsplit_score < 21)) || ((playerhand_score < 21) && (playerhandsplit_score < 21) && (dealerbust == true)){
                //Win: #Both hands beat dealer, #Dealer busts and none of the player hands do
                end_game_win()
            }
            else if (playerhand_score == 21) && (playerhandsplit_score == 21){
                //Blackjack: #Hand1 and Hand2 blackjack
                end_game_blackjack()
            }
            else if ((dealerhand_score > playerhand_score) && (dealerhand_score > playerhandsplit_score) && (dealerbust == false) && (playerhand_score < 21) && (playerhandsplit_score < 21)) || ((dealerhand_score > playerhand_score) && (dealerbust == false) && (playerhandsplit_score > 21) && (playerhand_score < 21)) || ((dealerhand_score > playerhandsplit_score) && (dealerbust == false) && (playerhand_score > 21) && (playerhandsplit_score < 21)){
                //Lose Game: #Dealer beats both hands, #Hand1 loses and Hand2 busts, #Hand2 loses and Hand1 busts
                end_game_lose()
            }
            else if ((playerhand_score == dealerhand_score) && ((playerhandsplit_score > 21) || ((playerhandsplit_score < dealerhand_score)&&(playerhandsplit_score < 21)))) || (((playerhand_score > 21)||((playerhand_score < dealerhand_score)&&(playerhand_score < 21))) && (playerhandsplit_score == dealerhand_score)){
                //HalfPush: #Hand1 push and Hand2 busts or loses to dealer, #Hand1 busts or loses to dealer and Hand2 push
                end_game_split_halfpush()
            }
            else if ((dealerbust == true) && (playerhand_score < 21) && (playerhandsplit_score == 21)) || ((playerhandsplit_score == 21) && (dealerbust == false) && (playerhand_score > dealerhand_score) && (playerhand_score < 21)) || ((dealerbust == true) && (playerhand_score == 21) && (playerhandsplit_score < 21)) || ((playerhand_score == 21) && (dealerbust == false) && (playerhandsplit_score > dealerhand_score) && (playerhandsplit_score < 21)){
                //1Blkj_1Win: #Dealer busts while Hand1 doeesn't bust and Hand2 blackjack, #Hand2 blackjack and Hand1 wins, #Dealer busts while Hand1 blackjack and Hand2 doesn't bust, #Hand1 blackjack and Hand2 wins
                end_game_split_oneblkjack_one_win()
            }
            else if ((playerhand_score == 21) && (playerhandsplit_score == dealerhand_score) && (playerhandsplit_score<21) && (dealerbust==false)) || ((playerhandsplit_score == 21) && (playerhand_score == dealerhand_score) && (playerhand_score<21) && (dealerbust==false)){
                //1Blkj_1Push: #Hand1 blackjack and Hand2 pushes, #Hand2 blackjack and Hand1 pushes
                end_game_split_onebljkack_onepush()
            }
            else if ((playerhand_score == 21) && (playerhandsplit_score > 21)) || ((playerhand_score == 21) && (playerhandsplit_score < 21) && (dealerbust == false) && (dealerhand_score > playerhandsplit_score)) || ((playerhand_score < 21) && (playerhandsplit_score == 21) && (dealerbust == false) && (dealerhand_score > playerhand_score)) || ((playerhandsplit_score == 21) && (playerhand_score > 21)){
                //1Blkj_1Loss: #Hand1 blackjack and Hand2 lose, #Hand2 blackjack and Hand1 lose, #Hand1 blackjack while Dealer and Hand2 busts, #Hand2 blackjack while Dealer and Hand1 busts
                end_game_split_oneblkjack_one_loss()
            }
        }
        
        else if dealerhand_score == playerhand_score{
            //Push
            end_game_reason = "Push"
            end_game_message = "Your hand was a push"
            end_game_push()
        }
        
        else if (playerhand_score == 21) && (dealerhand_score != 21){
            //Player blackjack win
            end_game_blackjack()
        }
        
        else if dealerbust == true && playerhand_score < 21{
            //Dealer busts
            end_game_win()
        }
        
        else if (dealerhand_score > playerhand_score) && (dealerbust == false) && (playerhand_score < 21){
            //Dealer wins higher hand
            end_game_lose()
        }

        else if (dealerhand_score < playerhand_score) && (playerhand_score < 21) && (dealerbust == false){
            //Player wins higher hand
            end_game_win()
        }
    }
    
    
    func player_turn(){
        //Draw card for player
        let playerrandom:Int = (Int.random(in: 1...13))
        let suitsrandom:Int = (Int.random(in: 0...3))
        playercards[playercards_dealt] = String(suits[suitsrandom]) + String(playerrandom)
        playercards_dealt += 1
        
        //Change value of playerrandom to make it its blackjack card value
        var value_added = 0
        if playerrandom > 1 && playerrandom < 10{
            value_added = playerrandom
        }
        else if playerrandom >= 10 {
            value_added = 10
        }
        else {
            if (playerhand_score + 11) <= 21{
                value_added = 11
                playerhave_ace = true
            }
            else{
                value_added = 1
            }
        }
        
        
        if (playerhand_score + value_added > 21) && (playerhave_ace == true){
            //If player has an ace that is currently being stored as an 11, make it a 1 so most recent drawn card can be used
            playerhand_score -= 10
            playerhave_ace = false
        }
        
        //Add most recent card to player's hand score
        playerhand_score += value_added
        
        //Keep player first two card values for splitting
        if playercards_dealt == 1{
            player_first_card = value_added
        }
        else if playercards_dealt == 2{
            player_second_card = value_added
        }
    }
    
    
    func playersplit2_turn(){
        //If player second split hand only has one hand and enough chips, allow double
        if ((Chips - double_split_bet) >= 0) && (playercardssplit_dealt < 2){
            can_double = true
        }
        else{
            can_double = false
        }
        
        let playerrandom:Int = (Int.random(in: 1...13))
        let suitsrandom:Int = (Int.random(in: 0...3))
        playersplitcards[playercardssplit_dealt] = String(suits[suitsrandom]) + String(playerrandom)
        playercardssplit_dealt += 1
        
        var value_added = 0
        if playerrandom > 1 && playerrandom < 10{
            value_added = playerrandom
        }
        else if playerrandom >= 10 {
            value_added = 10
        }
        else {
            if (playerhandsplit_score + 11) <= 21{
                value_added = 11
                playerhave_splitace = true
            }
            else{
                value_added = 1
            }
        }
        
        if (playerhandsplit_score + value_added > 21) && (playerhave_splitace == true){
            playerhandsplit_score -= 10
            playerhave_splitace = false
        }
        
        playerhandsplit_score += value_added
        
    }
    
    func end_game_split_halfpush(){
        Chips += (current_bet/2)
        end_game = true
        end_game_reason = "One hand push"
        end_game_message = "One hand was a push while the other hand lost"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    func end_game_split_onebljkack_onepush(){
        //Give player appropriate payout
        Chips += (current_bet/2) + Int(Double(current_bet/2)*2.5)
        
        //Check if it is the biggest_win for game ending alert
        if (current_bet/2) + Int(Double(current_bet/2)*2.5) > biggest_win{
            biggest_win = (current_bet/2) + Int(Double(current_bet/2)*2.5)
        }
        
        //Set variables for text used in game ending screen
        end_game = true
        end_game_reason = "Congrats on one hand"
        end_game_message = "One hand was a blackjack while the other hand was a push"
        
        //Reset variables to game start after short delay so player can read reason for ending and see the cards
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    func end_game_split_oneblkjack_one_win(){
        Chips += (current_bet) + Int(Double(current_bet/2)*2.5)
        if (current_bet) + Int(Double(current_bet/2)*2.5) > biggest_win{
            biggest_win = (current_bet) + Int(Double(current_bet/2)*2.5)
        }
        end_game = true
        end_game_reason = "One blackjack, one win"
        end_game_message = "One hand was a blackjack while the other hand won normally"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    
    func end_game_push(){
        Chips += current_bet
        end_game = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    func end_game_blackjack(){
        Chips += Int(Double(current_bet)*2.5)
        if Int(Double(current_bet)*2.5) > biggest_win{
            biggest_win = Int(Double(current_bet)*2.5)
        }
        end_game = true
        end_game_reason = "BlackJack!"
        end_game_message = "You got blackjack. Dealer pays 2.5x"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    func end_game_win(){
        Chips += (current_bet*2)
        if (current_bet*2) > biggest_win{
            biggest_win = (current_bet*2)
        }
        end_game = true
        end_game_reason = "Congrats"
        end_game_message = "You win. Dealer pays 2x"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    func end_game_lose(){
        //If player does not have enough chips to make more bets of 50 or above, end the game fully and restart progress
        if Chips <= 49{
            end_game = true
            end_game_reason = "You lost everything"
            end_game_message = "You have below the minimum bet and lost all money. Restarting chips. \nYour biggest win was: \(biggest_win)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9){
                reset()
                biggest_win = 0
                var chips:Int = (Int.random(in: 2000...6500))
                chips = (chips+50)/100 * 100
                Chips = chips
            }
        }
        else{
            end_game = true
            end_game_reason = "You lost"
            end_game_message = "Lost the current hand(s) and your chips."
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
                reset()
            }
        }
    }
    
    func end_game_split_oneblkjack_one_loss(){
        Chips += Int(Double((current_bet/2))*2.5)
        end_game = true
        end_game_reason = "Congrats on one hand"
        end_game_message = "One hand was a blackjack while the other lost"
        if Int(Double((current_bet/2))*2.5) > biggest_win{
            biggest_win = Int(Double((current_bet/2))*2.5)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2){
            reset()
        }
    }
    
    func reset(){
        //Cards of play
        playercards = ["","","","",""]
        playersplitcards = ["","","","",""]
        dealercards = ["","","","",""]
        dealerfirstcard = ""
        dealerfirstcard_value = 0
        //
        
        //Betting variables
        current_bet = 0
        last_bet = 0
        bets = [Int]()
        beting_allowed = true
        min_bet_placed = false
        double_split_bet = 0
        //
        
        //Dealing Cards
        playerhand_score = 0
        dealerhand_score = 0
        playerhandsplit_score = 0
        can_hit = false
        can_stand = false
        can_double = false
        can_split = false
        
        playerhave_ace = false
        playerhave_splitace = false
        dealerhave_ace = false
        dealerdone = false
        dealerbust = false
        end_game = false
        
        playercards_dealt = 0
        playercardssplit_dealt = 0
        dealercards_dealt = 0
        
        player_first_card = 0
        player_second_card = 0
        split_hand1 = Color.white
        split_hand2 = Color.white
        //
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
