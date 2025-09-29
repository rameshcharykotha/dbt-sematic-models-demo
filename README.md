# dbt Semantic Models Demo

This project demonstrates the power of dbt's semantic layer to define and query business metrics in a structured and scalable way. It provides a clear, hands-on example of how to build a simple yet effective semantic model on top of a dbt project.

## 🚀 Project Overview

The primary goal of this project is to showcase how to:
- **Structure a dbt project** to support a semantic layer.
- **Define semantic models** with entities, measures, and dimensions.
- **Create and query business-centric metrics** using dbt's `dbt sl` command.
- **Promote a shared understanding of business logic** by decoupling metric definitions from downstream tools.

This demo is built around a common business scenario: analyzing revenue and order data.

## ⚙️ Getting Started

Follow these steps to get the project up and running on your local machine.

### Prerequisites

- **dbt Core**: Ensure you have dbt Core installed. If not, follow the [official installation guide](https://docs.getdbt.com/dbt-cli/installation).
- **A dbt Profile**: You need a dbt profile to connect to your data warehouse. This project is configured to use a profile named `dbt_semantic_models_demo`. You can create or update your `profiles.yml` file (typically located at `~/.dbt/`) with the necessary connection details.

Here is an example of what your `profiles.yml` might look like:

```yaml
dbt_semantic_models_demo:
  target: dev
  outputs:
    dev:
      type: <your_data_warehouse> # e.g., snowflake, bigquery, redshift
      threads: 1
      ... # Add your connection details here
```

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   cd dbt_semantic_models_demo
   ```

2. **Install dbt packages**:
   ```bash
   dbt deps
   ```

3. **Load the seed data**:
   This project includes a sample dataset (`daily_revenue.csv`) to get you started quickly. Load it into your data warehouse by running:
   ```bash
   dbt seed
   ```
   This command creates the `daily_revenue` table in your source schema.

## 📂 Project Structure

The project is organized into the following key directories and files:

- **`models/`**: Contains the core dbt models.
  - **`sources.yml`**: Defines the raw data source (`daily_revenue`).
  - **`fct_revenue.sql`**: A simple fact model that cleans and prepares the revenue data.
  - **`semantic_models/`**: This is where the semantic layer is defined.
    - **`fct_revenue.yml`**: Defines the `revenue_model` with its entities, measures, and dimensions.
    - **`metrics.yml`**: Defines business metrics like `total_revenue_metric` and `avg_revenue_metric`.

- **`seeds/`**: Contains the raw CSV data (`daily_revenue.csv`) used to populate the source table.

- **`dbt_project.yml`**: The main configuration file for the dbt project.

## 📊 Models

### Source Data

The project uses a single source table, `public.daily_revenue`, which contains raw order and revenue information.

### Fact Model

- **`fct_revenue`**: This model serves as the foundation for our semantic layer. It selects and lightly prepares the data from the source table.

## 📈 Semantic Layer

The semantic layer is where the business logic is explicitly defined. It consists of two key components:

### Semantic Model

The `revenue_model` is defined in `models/semantic_models/fct_revenue.yml`. It includes:

- **Entities**:
  - `order` (primary)
  - `product` (foreign)
  - `customer` (foreign)

- **Measures**:
  - `total_revenue`: The sum of revenue, aggregated by the `order_date`.
  - `order_count`: The total count of orders.

- **Dimensions**:
  - `order_date` (time)
  - `region` (categorical)

### Metrics

The business metrics are defined in `models/semantic_models/metrics.yml`. These are the user-facing metrics that can be queried by business intelligence tools or through the dbt command line.

- **`total_revenue_metric`**: The total revenue across all orders.
- **`order_count_metric`**: The total number of orders.
- **`avg_revenue_metric`**: The average revenue per order, derived from the two metrics above.

## 🏃 Running the Project

Once you have completed the setup, you can run the project and query the semantic layer.

1. **Build the dbt models**:
   ```bash
   dbt build
   ```
   This command will run all models, tests, and seeds in your project.

2. **Query the semantic layer**:
   You can query the defined metrics using the `dbt sl` command. Here are a few examples:

   - **Get total revenue**:
     ```bash
     dbt sl query --metrics total_revenue_metric
     ```

   - **Get total revenue and order count, grouped by region**:
     ```bash
     dbt sl query --metrics total_revenue_metric order_count_metric --group-by region
     ```

   - **Get average revenue, grouped by month**:
     ```bash
     dbt sl query --metrics avg_revenue_metric --group-by order_month
     ```

By following this guide, you can explore how dbt's semantic layer provides a powerful and consistent way to define and analyze business metrics.