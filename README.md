# info201-yelp-simulator
# Leonhardsen Chandra, Isaac Kim, Jessica Luu, Grace Zhu

[Link to Shiny site](https://leonhardsen-chandra.shinyapps.io/info201-yelp-simulator/)

# INFO 201 Project Proposal
## Project Description
### Summary
We decided to choose **_Yelp's API_** and their **_dataset_** as we want to provide quicker and easier-to-use resources in comparison to Yelp's already popular resource to access restaurants, companies, etc. Due to size of data, we filtered the data down to the top ten cities in the US and the most popular cuisines based off Yelp's data. We decided to provide four different resources that users will be able to access to not only be able to quickly access specific resources, but also be able to visualize the information they are seeking. Yelp doesn't offer too many resources in which the user interface allows the user to visualize the information in forms other than things lists or words. The first resource we have is an **interactive map**. In comparison to the map that yelp already uses, this map can directly filter the city that a user is looking for and the cuisines they are interested in. Once a user chooses their desired options they can hover over color coded options in which displays information regarding the business. The next resource we have is a **word cloud**. This is a resource we have not seen on not only Yelp, but as well as other food/business/event/etc. search engines. This word cloud is useful to users that might be new to certain cuisines as it visually displays popular _key words_ that a certain cuisine may have. For example, the Vietnamese cuisine word cloud displays "Pho" as one of the biggest words because it is one of the most popular dishes amongst users. The next resource is a **chart** that quickly filters city and cuisine for a user to visually see their options. The difference between this and what Yelp already provides is accessibility and quickness. Immediately in the chart, it provides key information that the majority of users are looking for in restaurants. The last resource we have is a **plot** that compares average price and rating in major cities based on cuisine. Overall, our end goal is to provide an easy-to-use resource for Yelp users that might be looking for more visual representation of the information they're searching for.

### What major questions are we seeking to answer? What data can we use?
* How is this different from what Yelp _already_ provides?

Like said in the summary, Yelp already provides a great resource to discover different businesses based off a users preferences, however, our resource simplifies the Yelp search engine into four different specific tools. The interactive map allows users to get an idea of what the most popular cuisines are in selected cities and at the same time can view the location and details of each business by hovering. Our other tools including the word cloud, chart, and plot all offer users information and that answer different questions users may have. Some of those questions can be seen below.

* What's the _most popular_ cuisine in a certain city?

By using the **interactive map**, a user can select a major city and as well as a popular cuisine in order to discover the most popular cuisine based off of color coding. By viewing the legend on the side of the interactive map, you can see which cuisines are in majority. For example, if you choose Seattle and select all cuisines, based off the color coding you can see that American and Italian are extremely popular cuisines.

* What is the restaurants _food quality_ in terms of their _pricing_?

By using the **plot**, a user can choose a certain cuisine and then based off major cities, the plot will show a comparison between food quality and price. Often times, Yelp is ambiguous as to what the quality of the food is based on the price of the food. We think this is an important aspect of searching for food businesses that a lot of users will find helpful

* I've never tried _______ cuisine before, what is a popular food for this cuisine?

By using the **word map**, a user can choose a cuisine and the word map will display popular word choices that are in correlation to the cuisine. What this will do is show popular foods or keywords from a restaurant that a user can look at in order to see what is popular for that cuisine. An example is the Vietnamese cuisine where a word that shows is "Pho", which is a popular dish for the Vietnamese cuisine.

## Technical Description
To read in our data, we are using the Yelp REST API with a registered API key. We will need to subset our data by filtering the locations down to the city we select. We can further subset our data based on business categories and price range. In addition, we need to arrange the data based on the popularity of the locations. We have not decided to use any new libraries, but that may change as we begin to design our final project. We will use leaflet to build an interactive map for our audience. Our biggest challenge is obtaining the data and converting it into nice and easy to use csv files. Another challenge is ordering the data based on popularity, which includes many aspects such as rating score and number of reviews. Therefore, we need to create a metric to help us accurately measure the popularity.
