import argparse
import pandas as pd
import random
from datetime import datetime, timedelta


def generate_orders(rows=100):
    data = []

    categories = ["electronics", "fashion", "books", "sports", "home"]

    for i in range(rows):
        quantity = random.randint(1, 5)
        unit_price = round(random.uniform(10, 500), 2)

        data.append({
            "order_id": f"ORD-{i:05}",
            "customer_id": f"CUST-{random.randint(1000, 9999)}",
            "order_timestamp": datetime.now() - timedelta(days=random.randint(0, 30)),
            "product_category": random.choice(categories),
            "quantity": quantity,
            "unit_price": unit_price,
            "total_amount": round(quantity * unit_price, 2)
        })

    return pd.DataFrame(data)


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--rows",
        type=int,
        default=100
    )

    parser.add_argument(
        "--output",
        required=True
    )

    args = parser.parse_args()

    df = generate_orders(args.rows)

    df.to_csv(args.output, index=False)

    print(f"[INFO] Generated {len(df)} rows")


if __name__ == "__main__":
    main()
