from data_generator import generate_orders


def test_generate_orders():
    df = generate_orders(10)

    assert len(df) == 10

    required_columns = [
        "order_id",
        "customer_id",
        "product_category",
        "quantity",
        "unit_price",
        "total_amount"
    ]

    for col in required_columns:
        assert col in df.columns
