import '../model/services_mod.dart';

Map<String, Service> services = {
  "Lawn Care": Service(
    location: "maadi",
    title: "AHG Interiors",
    photo:
        "https://st.hzcdn.com/fimgs/c8e339fc01075aa0_1099-w240-h240-b1-p0--.jpg",
    provider: "Green Thumb Lawn Services",
    categories: "Interior Designers & Decorators",
    price: "50",
    reviews: [
      Reviews(
        image: "https://i.pravatar.cc/150?img=70",
        name: "khaled",
        rating: 5,
        comment: "My lawn has never looked better! Great job!",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://picsum.photos/id/237/200/300",
        name: "kareem",
        rating: 4,
        comment: "Very professional and courteous service.",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://i.pravatar.cc/150?img=30",
        name: "ahmed",
        rating: 2,
        comment: "https://i.pravatar.cc/150?img=3",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://i.pravatar.cc/150?img=37",
        name: "nasser",
        rating: 2,
        comment: "Very professional and courteous service.",
        timestamps: DateTime.now(),
      ),
    ],
    desc:
        "Green Thumb Lawn Services has been providing top-quality lawn care and landscaping services for over 15 years. We use only the best equipment and materials to ensure your lawn looks its best all year round.",
    gallery: [
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
    ],
  ),
  "Everything Home": Service(
    location: "maadi",
    title: "Kitchen Remodeling",
    photo:
        "https://st.hzcdn.com/fimgs/cff3157a0f77ae9a_9791-w240-h240-b1-p0--.jpg",
    provider: "Everything Home",
    categories: "Interior Designers & Decorators",
    price: "150",
    reviews: [
      Reviews(
        image: "https://i.pravatar.cc/150?img=4",
        name: "hassan",
        rating: 4,
        comment: "Great cleaning service, highly recommend!",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://i.pravatar.cc/150?img=34",
        name: "jane",
        rating: 5,
        comment: "They did an amazing job, my house looks spotless!",
        timestamps: DateTime.now(),
      ),
    ],
    desc:
        "Clean Sweep Housekeeping is a family-owned cleaning business with over 10 years of experience. We offer a variety of cleaning services to fit your needs and budget. Our staff are professional, reliable, and trustworthy.",
    gallery: [
      "https://plus.unsplash.com/premium_photo-1680382578871-32ce66f9ae25?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80",
      "https://images.unsplash.com/photo-1556911220-bff31c812dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1568&q=80",
      "https://images.unsplash.com/photo-1600585152220-90363fe7e115?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    ],
  ),
  "Horizon Construction & Remodeling": Service(
    location: "elzahraa",
    title: "Interior Design",
    photo:
        "https://st.hzcdn.com/fimgs/e32396ef0d8b84e9_0091-w240-h240-b1-p0--.jpg",
    provider: "Horizon Construction & Remodeling",
    categories: "Home Builders",
    price: "100",
    reviews: [
      Reviews(
        image: "https://i.pravatar.cc/150?img=36",
        name: "johndoe",
        rating: 4,
        comment: "Great dog walking service, my pup loves them!",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://i.pravatar.cc/150?img=46",
        name: "janedoe",
        rating: 5,
        comment: "Professional and reliable, would definitely recommend!",
        timestamps: DateTime.now(),
      ),
    ],
    desc:
        """ | With locations in Minnesota and Texas, we work with homeowners from coast to coast to design and furnish their interiors. Contact us today for more information!

Martha O’Hara Interiors designs beautiful spaces with the goal of connecting life and style. Finding that enviable mix of style and warmth that exudes your true aesthetic and sticks to your budget - it's what we do best! 

Whether you are building, remodeling, or updating your furniture, our award-winning team will create an interior that is tailored to your tastes and lifestyle. With locations in Minnesota and Texas, we work with homeowners and building professionals from """,
    gallery: [
      "https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1700&q=80",
      "https://images.unsplash.com/photo-1633505765486-e404bbbec654?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80",
      "https://images.unsplash.com/photo-1633505650701-6104c4fc72c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80",
      "https://images.unsplash.com/photo-1633505528166-407a12a88a04?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80"
    ],
  ),
  "By Design Interiors, Inc.": Service(
    location: "maadi",
    title: "Playroom Design",
    photo:
        "https://st.hzcdn.com/fimgs/ab734bb301081419_7968-w240-h240-b1-p0--.jpg",
    provider: "Pawsitively Perfect Pet Services",
    categories: "Interior Designers & Decorators",
    price: "100",
    reviews: [
      Reviews(
        image: "https://i.pravatar.cc/150?img=31",
        name: "johndoe",
        rating: 4,
        comment: "Great dog walking service, my pup loves them!",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://i.pravatar.cc/150?img=61",
        name: "janedoe",
        rating: 5,
        comment: "Professional and reliable, would definitely recommend!",
        timestamps: DateTime.now(),
      ),
    ],
    desc:
        "Pawsitively Perfect Pet Services is dedicated to providing the best possible care for your furry friends. Our experienced dog walkers will give your pup the exercise and attention they need while you're away.",
    gallery: [
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
    ],
  ),
  "Rerooms": Service(
    location: "maadi",
    title: "Dog Walking",
    photo:
        "https://st.hzcdn.com/fimgs/cff3157a0f77ae9a_9791-w240-h240-b1-p0--.jpg",
    provider: "Pawsitively Perfect Pet Services",
    categories: "Interior Designers & Decorators",
    price: "100",
    reviews: [
      Reviews(
        image: "https://i.pravatar.cc/150?img=45",
        name: "johndoe",
        rating: 4,
        comment: "Great dog walking service, my pup loves them!",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "52",
        name: "janedoe",
        rating: 5,
        comment: "Professional and reliable, would definitely recommend!",
        timestamps: DateTime.now(),
      ),
    ],
    desc:
        "Pawsitively Perfect Pet Services is dedicated to providing the best possible care for your furry friends. Our experienced dog walkers will give your pup the exercise and attention they need while you're away.",
    gallery: [
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
    ],
  ),
  "Urbane Design": Service(
    location: "maadi",
    title: "Dog Walking",
    photo:
        "https://st.hzcdn.com/fimgs/cff3157a0f77ae9a_9791-w240-h240-b1-p0--.jpg",
    provider: "Pawsitively Perfect Pet Services",
    categories: "Interior Designers & Decorators",
    price: "100",
    reviews: [
      Reviews(
        image: "https://i.pravatar.cc/150?img=55",
        name: "johndoe",
        rating: 4,
        comment: "Great dog walking service, my pup loves them!",
        timestamps: DateTime.now(),
      ),
      Reviews(
        image: "https://i.pravatar.cc/150?img=64",
        name: "janedoe",
        rating: 5,
        comment: "Professional and reliable, would definitely recommend!",
        timestamps: DateTime.now(),
      ),
    ],
    desc:
        "Pawsitively Perfect Pet Services is dedicated to providing the best possible care for your furry friends. Our experienced dog walkers will give your pup the exercise and attention they need while you're away.",
    gallery: [
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
      "https://st.hzcdn.com/simgs/pictures/living-rooms/eliza-and-mike-ahg-interiors-img~96a16b1e0bb2e77e_9-0027-1-21cb1f2.jpg",
    ],
  ),
};
