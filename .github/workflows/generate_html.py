import lxml.etree as ET
import os
from playwright.sync_api import sync_playwright
import pathlib

directory = os.getcwd()

# Paths for input XML and output HTML
xslt_file = os.path.join(directory, ".github/workflows/checklists-html.xslt")  # Replace with your XSLT file path

# Parse XML and XSLT
xslt_tree = ET.parse(xslt_file)
transform = ET.XSLT(xslt_tree)

for file in os.listdir(directory):
    filename = os.fsdecode(file)
    if(filename.endswith(".aircraft")):
        xml_tree = ET.parse(filename)

        # Apply transformation
        html_result = transform(xml_tree)

        output_html = filename.replace(".aircraft", ".html")
        output_pdf = filename.replace(".aircraft", ".pdf")

        # Save the result as HTML
        with open(output_html, "wb") as f:
            f.write(ET.tostring(html_result, pretty_print=True, method="html"))

        
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()
            page.goto(f"{pathlib.Path(os.path.join(directory, output_html)).as_uri()}")
            page.pdf(path=output_pdf, format="A5", print_background=True)
            browser.close()

print(f"HTML files generated successfully")