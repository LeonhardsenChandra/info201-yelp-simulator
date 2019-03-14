# info201-yelp-simulator
# Leonhardsen Chandra, Isaac Kim, Jessica Luu, Grace Zhu

# INFO 201 Project Proposal
## Project Description
Our group will be working with Yelp’s API and dataset. As a team we brainstormed several different ideas that ranged from using Spotify’s dataset to create a data model similar to their end of year wrap up, to analyzing sports data statistics. Upon discovering these different datasets, we stumbled upon Yelp’s dataset. We found this data set by simply googling for Yelp’s dataset as it is accessible to the public. Different datasets that Yelp provides to the public can be accessed through their Yelp Developers portion of their website: https://www.yelp.com/developers. We will be selecting specific portions of data from this dataset to create a resource for communicating our insights. 
Our target audience aims broadly at individuals seeking businesses in a specific area with different requirements, and specifically towards groups such as tourists that are in need of using a resource to discover things based off their desires. Diving deeper into the example of a tourist and an example of a user persona, a tourist can potentially be visiting Seattle, Washington from Los Angeles, California and needs to find a place to eat for the night that includes the following requirements: good price, most popular (defined by reviews), and nearby. 
What our audience would want to learn from our data is the accessibility of finding their desired businesses through a resource such as an interactive map that matches their needs. We can pose the following questions that our project will answer for the audience. 

Questions:
- What type of restaurant do people in each state go to the most for breakfast/lunch/dinner?
- What is the most popular type of restaraunt in each state? Across the country?
- Which area has the best Mexican/Italian/etc. restaurants?

## Technical Description
To read in our data, we are using the Yelp REST API with a registered API key. We will need to subset our data by filtering the locations down to the city we select. While Yelp is primarily known for their collective reviews of restaurants, they also provides reviews for different business categories such as accounting, spas, dentists and more. We can further subset our data based on business categories and price range. In addition, we need to arrange the data based on the popularity of the locations. We have not decided to use any new libraries, but that may change as we begin to design our final project. We will use leaflet to build an interactive map for our audience. Our biggest challenge is ordering the data based on popularity, which includes many aspects such as rating score and number of reviews. Therefore, we need to create a metric to help us accurately measure the popularity.
