#!/usr/bin/env python3
"""
Script to provide stats about Nginx logs stored in MongoDB.
"""

from pymongo import MongoClient

def nginx_stats():
    client = MongoClient("mongodb://localhost:27017/")
    db = client.logs
    collection = db.nginx

    # Total number of documents
    total_logs = collection.count_documents({})

    # Count methods
    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    method_counts = {method: collection.count_documents({"method": method}) for method in methods}

    # Count GET /status
    status_check = collection.count_documents({"method": "GET", "path": "/status"})

    # Printing the results
    print(f"{total_logs} logs")
    print("Methods:")
    for method in methods:
        print(f"\tmethod {method}: {method_counts[method]}")
    print(f"{status_check} status check")


if __name__ == "__main__":
    nginx_stats()
