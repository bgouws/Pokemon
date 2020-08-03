# Pokemon - ABSA Take home project

This project is a take home project given to me by ABSA, majority of the UI is created in story boards and it follows the MVVM Architecture and make use of the PokeApi: https://pokeapi.co

# Summary - Walkthrough

## Pokedex (Screen 1)

When the user opens the application they are greeted with the Pokedex screen, here they are able to scroll through all the existing Pokemon, this is acomplished by making paginated requests, which will only download the data that the user wants to see, this makes the user experience great as the user is not limited by a predetermind cap as well as the application is not using too much data as it is loading this information on demand. 

Screenshot: 




If the user were interested in one of the Pokemon they see in the UICollectionView they can simply tap on that Pokemon and they will navigate to a SingleView of the selected Pokemon, where the image will be displayed more prominently and other information about the Pokemon can be found underneath the image.


## Search (Screen 2)

The user can navigate to this screen by selecting the search icon in the UITabBar, they will be greeted with a screen with a search bar where they can enter a Pokemons name, it will actively filter the names of the Pokemon which will also encourage the user to explore and discover, the PokeApi does not have a search enpoint, so this feature was create by me, once the user is done searching they can click on any of the results that are being displayed, similarly to the Pokedex screen this will allow the user to navigate to a SingleView screen, where they can see more information about the selescted Pokemon. 

Screenshot: 


## SingleView (Screen 3)

On this screen the user will be able to see a Pokemon in greater detail than the other screens, this screen is reused and will either use the already downloaded content from the Pokedex screen or it will fetch the selected Pokemon from the search screen. 

Screenshot: 


# Limitations of the API: 

It seems that the API has a few limitations namely: 

- No built in search
- A lot of nested data which requires multiple calls


I was able to overcome most of these limitations, although I know they are not as efficient as they could be if the limitations were not present. 

### Search Limitation

The PokeApi has no built in search, so I needed to create the search feature from scratch, which requires filtering a large array, this is not too costly at this stage, but if the number of Pokemon were to grow substantially a new alternative would need to be found. 

### Nested Data

The PokeApi has a lot of nested data and to get all the data required normally needs multiple service calls, for example here is the response from hitting the BaseURL: https://pokeapi.co/api/v2/pokemon

Screenshot: 

This seems to be the only way to get a list of the Pokemon, and as you can see, if you wanted to get more detail on an individual Pokemon you would need to make another service call, with the url provided in this response, which I needed to do for the Pokedex screen. So to present a list of Pokemon with an image of how the Pokemon looks requires a little more work than expected. 

# Other Features and Improvements I would/Wanted to add if given the time







