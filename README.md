# Guess the country

"Who Wants to Be a Millionaire?" style game made with Processing. Short and fun game to compete with friends.

![screenshot 1](https://github.com/ricardoreais/guess-the-country/blob/master/examples/menu.png "Game mode 1")

![screenshot 2](https://github.com/ricardoreais/guess-the-country/blob/master/examples/mode1.png "Game mode 1")

[Click here for more  in-game screenshots](https://github.com/ricardoreais/guess-the-country/tree/master/examples)

## Code Example

The game main engine is the random generator, which allows multiple combinations of the same game by generating random wrong answers, random wrong answers positions and also a random image.

```Processing
void generator() // Generates a completly new set of answers
{
  currentCountry = countries[rLandscapes.get(clicker)]; // New country
  currentCountryPosition = rLandscapes.get(clicker); //New country position
  rCountries.clear(); //Erases random array of numbers
  rPositions.clear(); //Erases random array of positions
  randomCountries(); //List with random countries (i.e. country index)
  randomPositions(); //List with random positions (position A, position B, position C & position D)
  if(flagMode1)  
    generateFlags(); //Generate new flags
  else if(flagMode2)
    generateAnswers(); //Generate new answers
}
```

## Getting Started
### Prerequisites

You will need to download processing version 3.x.

[Click here to download Processing](https://processing.org/download/)

### Opening the project

Once you have to Processing editor on the left upper corner, click on File>open...>guessTheCountry.pde

This will open the game project.

## Running the game

You can run the game by clicking the "Play" button on the processing IDE.

## Deployment

Export the application and make an executable file. On the left upper corner, click on File>Export application...

## Built With

* [Processing 3.3](https://processing.org/download/) - The IDE used.
* [Adobe photoshop](https://www.adobe.com/pt/products/photoshop.html?promoid=KLXLS&mv=search&s_kwcid=AL!3085!3!180232924738!b!!g!!adobe%20photoshop%20gr%C3%A1tis&ef_id=WL7ZFwAAACZ40aWn:20170314164153:s) - The artwork editor.

## Authors

* **Ricardo Reais** - *Initial work* - [My profile](https://github.com/ricardoreais)

See also the list of [contributors](https://github.com/ricardoreais/guess-the-country/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
