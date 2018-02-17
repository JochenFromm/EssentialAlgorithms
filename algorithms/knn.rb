
# k-nearest neighbors algorithm
# https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm

module Knn
  # get hash with most frequent dimension values like
  # { "year" => [1930, 1931, 1932,..],
  #   genre" => ["Comedy", "Documentary", "Action"],
  #   "cast" => ["Oliver Hardy", "Buster Keaton", ..] }
  def self.get_top_dimensions(data, keys = %w(year genre cast), top = 20)
    result = {}
    keys.each do |key|
      values = {}
      data.select{ |d| d[key] }
          .map{ |d| d[key].to_s.split(',') }
          .flatten.each do |key|
        name = key.strip
        values[name] ? values[name]+=1 : values[name]=1
      end
      result[key] = values.select{ |key, value| value > top }.keys
    end
    result
  end

  # get all dimension values from data set
  def self.get_dimensions(data, keys = %w(year genre cast))
    result = {}
    keys.each do |key|
      result[key] = data.select { |d| d[key] }
                        .map { |d| d[key].to_s.split(',') }
                        .flatten
                        .map {|s| s.strip}
                        .uniq.compact
    end
    result
  end

  def self.dimension_values(data, dimension, values)
    values.map do |keyword|
      data[dimension].to_s.include?(keyword) ? 1 : 0
    end
  end

  def self.get_feature_vector_list(data, dimensions)
    data.map do |entry|
      get_classification(entry, dimensions)
    end
  end

  # classifies data and returns feature vector
  def self.get_classification(data, dimensions)
    vector = []
    dimensions.each do |dimension, values|
      vector << dimension_values(data, dimension, values)
    end
    vector.flatten
  end

  def self.explain_classification(vector, dimensions)
    dimension_values = []
    dimensions.each do |dimension, values|
      dimension_values << values
    end
    dimension_values.flatten.zip(vector).map{|v| v.last == 1 ? v.first : nil}.compact
  end

  # main function, compares feature vectors by certain metric
  def self.similar_items(feature_vector, list_of_vectors, threshold = 4)
    result = []
    list_of_vectors.each_with_index do |vector, index|
      distance = euclidean_distance(vector, feature_vector)
      result << index if distance <= threshold
    end
    result
  end

  def self.euclidean_distance(v1, v2)
    Math.sqrt(v1.zip(v2).map { |v| (v[1] - v[0])**2 }.reduce(:+))
  end

  def self.manhattan_distance_a(v1, v2)
    v1.zip(v2).map {|v| (v[1] - v[0]).abs}.reduce(:+)
  end
end

# usage
# $ sh/c
#
# data = JSON.parse(File.read('examples/movies.json')); nil
# movie = data.select{|d| d["title"] && d["title"].include?("Jaws") }.first
# dimensions = Knn.get_top_dimensions(data); nil
# list = Knn.get_feature_vector_list(data, dimensions); nil
# feature_vector = Knn.get_classification(movie, dimensions); nil
# Knn.explain_classification(feature_vector, dimensions)
# result = Knn.similar_items(feature_vector, list, 2); nil
# result.each { |index| puts "* "+data[index]["title"] }; nil
