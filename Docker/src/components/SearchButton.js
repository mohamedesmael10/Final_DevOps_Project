import React from 'react';
import { Link } from 'react-router-dom';

const SearchButton = () => {
    return (
        <Link
            to='/search'
            className="open-search"
            >Add a book</Link>
    )
}

export default SearchButton