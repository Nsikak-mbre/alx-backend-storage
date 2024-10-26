#!/usr/bin/env python3
"""
Module to list all documents in a collection.
"""


def list_all(mongo_collection):
    """
    List all documents in a collection.
    """
    documents = []
    for doc in mongo_collection.find():
        documents.append(doc)
    return documents


if __name__ == "__main__":
    pass  # This block ensures the script doesn't run when imported
