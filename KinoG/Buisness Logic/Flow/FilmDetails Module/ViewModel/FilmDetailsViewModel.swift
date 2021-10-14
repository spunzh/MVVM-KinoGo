// FilmDetailsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol FilmDetailsViewModelProtocol {
    var updateViewData: ((FilmViewData<Film>) -> Void)? { get set }
    var filmID: Int? { get set }
    func getFilmDetails()
    func loadImage(path: String, completion: @escaping (Data?) -> ())
}

final class FilmDetailsViewModel: FilmDetailsViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData<Film>) -> Void)?
    var filmID: Int?

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol?
    private let imageAPIService: ImageAPIServiceProtocol?

    // MARK: - Initialization

    init(filmID: Int, networkService: MovieAPIServiceProtocol, imageService: ImageAPIServiceProtocol) {
        self.filmID = filmID
        movieAPIService = networkService
        imageAPIService = imageService
        getFilmDetails()
    }

    // MARK: - Public Methods

    func getFilmDetails() {
        guard let filmID = filmID else { return }

        movieAPIService?.getFilmDetails(filmID: filmID) { [weak self] result in
            switch result {
            case let .success(film):
                self?.updateViewData?(.success(film))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func loadImage(path: String, completion: @escaping (Data?) -> ()) {
        imageAPIService?.loadImage(url: path) { results in
            switch results {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
