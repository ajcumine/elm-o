module Reddit exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline
import RemoteData exposing (WebData)



-- main


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- model


type alias Thread =
    { title : String
    , url : String
    , over18 : Bool
    , thumbnail : String
    , subreddit : String
    , permalink : String
    }


type alias Threads =
    { kind : String
    , data : List Thread
    }


type Model
    = Failure
    | Loading
    | Success Threads



-- msg


type Msg
    = ThreadsResponse (WebData Threads)



-- init


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getRedditThreads )



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ThreadsResponse result ->
            case result of
                RemoteData.Success threads ->
                    ( Success threads, Cmd.none )

                RemoteData.Failure _ ->
                    ( Failure, Cmd.none )

                _ ->
                    ( Loading, Cmd.none )



--serialisation


threadDecoder : Decoder Thread
threadDecoder =
    Decode.succeed Thread
        |> Pipeline.requiredAt [ "data", "title" ] Decode.string
        |> Pipeline.requiredAt [ "data", "url" ] Decode.string
        |> Pipeline.requiredAt [ "data", "over_18" ] Decode.bool
        |> Pipeline.requiredAt [ "data", "thumbnail" ] Decode.string
        |> Pipeline.requiredAt [ "data", "subreddit_name_prefixed" ] Decode.string
        |> Pipeline.requiredAt [ "data", "permalink" ] Decode.string


threadsDecoder : Decoder Threads
threadsDecoder =
    Decode.succeed Threads
        |> Pipeline.required "kind" Decode.string
        |> Pipeline.requiredAt [ "data", "children" ] (Decode.list threadDecoder)



-- fetch


getRedditThreads : Cmd Msg
getRedditThreads =
    Http.get
        { url = "https://www.reddit.com/r/all.json"
        , expect = Http.expectJson (RemoteData.fromResult >> ThreadsResponse) threadsDecoder
        }



-- view


viewThread : Thread -> Html Msg
viewThread thread =
    Html.div
        []
        [ Html.h3
            [ href thread.url ]
            [ Html.text thread.title ]
        , Html.p
            []
            [ Html.a
                [ href ("https://www.reddit.com/" ++ thread.subreddit) ]
                [ Html.text thread.subreddit ]
            ]
        , Html.a
            [ href thread.url ]
            [ Html.img
                [ src thread.thumbnail ]
                []
            ]
        , Html.p
            []
            [ Html.a
                [ href ("https://www.reddit.com" ++ thread.permalink) ]
                [ Html.text "thread" ]
            ]
        ]


view : Model -> Html Msg
view model =
    Html.div
        []
        [ Html.h1 [] [ Html.text "REDDIT /r/all" ]
        , Html.div
            []
            (case model of
                Success threads ->
                    threads.data
                        |> List.filter (\thread -> thread.over18 == False)
                        |> List.map (\thread -> viewThread thread)

                Loading ->
                    [ Html.h3
                        []
                        [ Html.text "Loading..." ]
                    ]

                Failure ->
                    [ Html.h3
                        []
                        [ Html.text "There was an error loading your content" ]
                    ]
            )
        ]
