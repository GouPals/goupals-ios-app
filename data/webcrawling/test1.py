import aiohttp
import asyncio
from bs4 import BeautifulSoup

async def fetch(session, url):
    async with session.get(url) as response:
        return await response.text()

async def parse_product(html_content):
    soup = BeautifulSoup(html_content, 'lxml')
    
    name = soup.find('meta', {'property': 'og:title'})['content']
    description_tag = soup.find('meta', {'name': 'description'})
    description = description_tag['content'] if description_tag else "No description available."
    price_tag = soup.find('meta', {'property': 'product:price:amount'})
    price = price_tag['content'] if price_tag else "Price not available."
    image_tags = soup.find_all('meta', {'property': 'og:image'})
    images = [img['content'] for img in image_tags]

    return {
        'name': name,
        'description': description,
        'price': price,
        'images': images
    }

async def extract_louis_vuitton_products(urls):
    async with aiohttp.ClientSession() as session:
        tasks = []
        for url in urls:
            tasks.append(fetch(session, url))
        html_contents = await asyncio.gather(*tasks)
        products = await asyncio.gather(*[parse_product(content) for content in html_contents])
        return products

urls = [
    "https://us.louisvuitton.com/eng-us/products/speedy-bandouliere-25-nvprod3160026v/M59273",
    # Add more URLs here
]

loop = asyncio.get_event_loop()
products_details = loop.run_until_complete(extract_louis_vuitton_products(urls))
print(products_details)
