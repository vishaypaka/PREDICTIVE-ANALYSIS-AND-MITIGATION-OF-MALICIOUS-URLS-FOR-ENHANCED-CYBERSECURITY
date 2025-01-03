<h1>Phishing Website Detection: Data Analysis and Predictive Modeling</h1>

<p>This repository showcases the project on phishing website detection using data analysis and machine learning techniques. It involves cleaning the data, performing exploratory data analysis (EDA), and building predictive models to detect malicious websites. The project integrates R for data cleaning and visualization and Python for predictive modeling.</p>

<h2>Project Overview</h2>
<p>The dataset used for this project contains features related to phishing websites. Due to the large size of the dataset (2.4 million records), it is not directly included in this repository. You can access and download the dataset from the following link: <a href="https://huggingface.co/datasets/FredZhang7/malicious-website-features-2.4M" target="_blank">Malicious Website Features Dataset (2.4M records)</a>.</p>

<h2>Files in the Repository</h2>
<ul>
  <li><code>Data_Cleaning_Statistical_and_Descriptive_Analysis.R</code>: R script for data cleaning and exploratory data analysis (EDA).</li>
  <li><code>Final_Project_Modelling.ipynb</code>: Python notebook for predictive modeling using machine learning algorithms.</li>
  <li><code>Final_Project_Modelling.html</code>: HTML export of the Python notebook providing an overview of the project.</li>
  <li><code>READ_ME.rtf</code>: Instructions for running the project files.</li>
</ul>

<h2>Steps to Execute the Project</h2>
<ol>
  <li>Download the dataset from the <a href="https://huggingface.co/datasets/FredZhang7/malicious-website-features-2.4M" target="_blank">Hugging Face Dataset Page</a>.</li>
  <li>Open the R script <code>Data_Cleaning_Statistical_and_Descriptive_Analysis.R</code> in RStudio along with the dataset file and execute the script to clean the data and perform EDA.</li>
  <li>The cleaned dataset <code>phishing_features_cleaned_data.csv</code> will be automatically generated.</li>
  <li>Open the Python notebook <code>Final_Project_Modelling.ipynb</code> in Jupyter Notebook or any compatible platform along with the cleaned dataset, and execute the notebook to perform predictive modeling.</li>
  <li>For an overview, refer to the HTML file <code>Final_Project_Modelling.html</code>.</li>
</ol>

<h2>Key Features</h2>
<ul>
  <li><strong>Data Cleaning:</strong> Handled in R to address missing values, replace incorrect entries, and normalize data.</li>
  <li><strong>Exploratory Data Analysis:</strong> Includes correlation plots, boxplots, and bar charts to visualize relationships between features and target variables.</li>
  <li><strong>Predictive Modeling:</strong> Utilizes machine learning models such as Decision Trees, Random Forests, and Logistic Regression to predict website legitimacy.</li>
</ul>

<h2>Technologies Used</h2>
<ul>
  <li><strong>Languages:</strong> R, Python</li>
  <li><strong>Libraries:</strong> dplyr, ggplot2, caret (R); pandas, scikit-learn, matplotlib (Python)</li>
</ul>

<h2>Instructions and Insights</h2>
<ul>
  <li>Follow the steps in <code>READ_ME.rtf</code> to ensure smooth execution of the project files.</li>
  <li>Ensure the cleaned dataset is used for predictive modeling to achieve accurate results.</li>
  <li>Refer to the HTML overview for a quick glance at the project's results and workflow.</li>
</ul>

<h2>Future Enhancements</h2>
<ul>
  <li>Implement deep learning techniques for improved accuracy.</li>
  <li>Develop a web-based application to deploy the phishing detection model for real-time use.</li>
  <li>Incorporate additional datasets to enhance the model's robustness and scalability.</li>
</ul>

<p>This project demonstrates the integration of data analysis and predictive modeling to address cybersecurity challenges by detecting phishing websites effectively.</p>
