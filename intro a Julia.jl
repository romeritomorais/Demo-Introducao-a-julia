using CSV;
using DataFrames;
using Statistics;

println("meu diretorio atual:", pwd())

movies_df = DataFrame(CSV.File("/home/romerito/Documents/dataset/movies.csv"))
first(movies_df, 5)

names(movies_df)

eltype.(eachcol(movies_df))

size(movies_df)

rename!(movies_df, :filmtv_id => :id,
                   :titolo_originale => :titulo,
                   :titolo_italiano => :null,
                   :anno => :ano,
                   :genere => :genero,
                   :durata => :duracao,
                   :paese => :país,
                   :registi => :diretores,
                   :attori => :atores,
                   :voto_medio => :voto_medio,
                   :voti => :votos,
                   :descrizione => :descricao,
                   :note => :notas,
                   :miglior_commento => :melhor_comentario)

names(movies_df)

select!(movies_df, Not([:id,
                        :null,
                        :melhor_comentario, 
                        :diretores,
                        :atores,
                        :voto_medio,
                        :descricao,
                        :país,
                        :notas]))

names(movies_df)

eltype.(eachcol(movies_df))

first(movies_df,2)

mean(movies_df.votos),
mean(movies_df.duracao)

sort!(movies_df, :ano);

movies_df = dropmissing(movies_df)

mean(movies_df.votos),
mean(movies_df.duracao)

names(movies_df)

first(movies_df,5)

movies_df[occursin.("Biblico", movies_df.genero), :]

groupby(movies_df, [:genero])

by(movies_df, [:genero], movies_df -> mean(movies_df[:, :votos]))

by(movies_df, :ano, nrow)

movies_df.duracao

movies_df[!, :duracao_horas] = movies_df.duracao / 60

names(movies_df)

mean(movies_df.duracao_horas)

movies_df[:,[:titulo,:duracao,:duracao_horas]]

#delete
select!(movies_df, Not(:duracao_horas))

#filtrar periodos
movies_df[.&(movies_df.ano .> 2000, movies_df.ano .< 2002), : ]

movies_df[.&(movies_df.ano .> 2000, movies_df.duracao .== 60), : ]

CSV.write("new01.csv", movies_df, append=false)

;ls -n


