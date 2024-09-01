import requests
from bs4 import BeautifulSoup

# URL of the iPhone 15 Pro page
url = "https://www.apple.com/ca/shop/buy-iphone/iphone-15-pro"

# Send a GET request to the URL
response = requests.get(url)

# Parse the page content with BeautifulSoup
soup = BeautifulSoup(response.content, 'html.parser')

# Extract the product name using the appropriate tag and class
product_name_tag = soup.find('meta', attrs={"name": "apple:product-name"})
product_name = product_name_tag['content'] if product_name_tag else "Product name not found"

# Extract the description using a different approach
description_tag = soup.find('meta', attrs={"name": "description"})
description = description_tag['content'] if description_tag else "Description not found"

# Extract the price using a more general approach
price_tag = soup.find('meta', attrs={"property": "og:price:amount"})
price = f"CAD {price_tag['content']}" if price_tag else "Price not found"

# Print the extracted information
print(f"Product Name: {product_name}")
print(f"Description: {description}")
print(f"Price: {price}")
