# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "unaccent"

  create_table "author", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",     limit: 8,    default: 0,     null: false
    t.string   "abbrev",           limit: 100
    t.datetime "created_at",                                    null: false
    t.string   "created_by",       limit: 255,                  null: false
    t.string   "date_range",       limit: 50
    t.integer  "duplicate_of_id",  limit: 8
    t.string   "full_name",        limit: 255
    t.string   "ipni_id",          limit: 50
    t.string   "name",             limit: 1000
    t.integer  "namespace_id",     limit: 8,                    null: false
    t.string   "notes",            limit: 1000
    t.integer  "source_id",        limit: 8
    t.string   "source_id_string", limit: 100
    t.string   "source_system",    limit: 50
    t.boolean  "trash",                         default: false, null: false
    t.datetime "updated_at",                                    null: false
    t.string   "updated_by",       limit: 255,                  null: false
    t.boolean  "valid_record",                  default: false, null: false
  end

  add_index "author", ["abbrev"], name: "author_abbrev_index", using: :btree
  add_index "author", ["abbrev"], name: "uk_9kovg6nyb11658j2tv2yv4bsi", unique: true, using: :btree
  add_index "author", ["name"], name: "author_name_index", using: :btree
  add_index "author", ["namespace_id", "source_id", "source_system"], name: "auth_source_index", using: :btree
  add_index "author", ["source_id_string"], name: "auth_source_string_index", using: :btree
  add_index "author", ["source_system"], name: "auth_system_index", using: :btree

  create_table "comment", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version", limit: 8,  default: 0, null: false
    t.integer  "author_id",    limit: 8
    t.datetime "created_at",                          null: false
    t.string   "created_by",   limit: 50,             null: false
    t.integer  "instance_id",  limit: 8
    t.integer  "name_id",      limit: 8
    t.integer  "reference_id", limit: 8
    t.text     "text",                                null: false
    t.datetime "updated_at",                          null: false
    t.string   "updated_by",   limit: 50,             null: false
  end

  add_index "comment", ["author_id"], name: "comment_author_index", using: :btree
  add_index "comment", ["instance_id"], name: "comment_instance_index", using: :btree
  add_index "comment", ["name_id"], name: "comment_name_index", using: :btree
  add_index "comment", ["reference_id"], name: "comment_reference_index", using: :btree

  create_table "db_version", id: :bigserial, force: :cascade do |t|
    t.integer "version", null: false
  end

  create_table "delayed_jobs", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version", limit: 8,                             default: 0, null: false
    t.decimal  "attempts",                  precision: 19, scale: 2
    t.datetime "created_at",                                                     null: false
    t.datetime "failed_at"
    t.text     "handler"
    t.text     "last_error"
    t.datetime "locked_at"
    t.string   "locked_by",    limit: 4000
    t.decimal  "priority",                  precision: 19, scale: 2
    t.string   "queue",        limit: 4000
    t.datetime "run_at"
    t.datetime "updated_at",                                                     null: false
  end

  create_table "external_ref", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",         limit: 8,                           default: 0, null: false
    t.string  "external_id",          limit: 50,                                      null: false
    t.string  "external_id_supplier", limit: 50,                                      null: false
    t.integer "instance_id",          limit: 8,                                       null: false
    t.integer "name_id",              limit: 8,                                       null: false
    t.string  "object_type",          limit: 50
    t.decimal "original_provider",               precision: 19, scale: 2
    t.integer "reference_id",         limit: 8,                                       null: false
  end

  create_table "help_topic", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",   limit: 8,    default: 0,     null: false
    t.datetime "created_at",                                  null: false
    t.string   "created_by",     limit: 4000,                 null: false
    t.text     "marked_up_text",                              null: false
    t.string   "name",           limit: 4000,                 null: false
    t.integer  "sort_order",                  default: 0,     null: false
    t.boolean  "trash",                       default: false, null: false
    t.datetime "updated_at",                                  null: false
    t.string   "updated_by",     limit: 4000,                 null: false
  end

  create_table "id_mapper", id: :bigserial, force: :cascade do |t|
    t.integer "from_id",      limit: 8,  null: false
    t.integer "namespace_id", limit: 8,  null: false
    t.string  "system",       limit: 20, null: false
    t.integer "to_id",        limit: 8
  end

  add_index "id_mapper", ["from_id", "namespace_id", "system"], name: "id_mapper_from_index", using: :btree
  add_index "id_mapper", ["to_id", "from_id"], name: "unique_from_id", unique: true, using: :btree

  create_table "instance", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",         limit: 8,    default: 0,     null: false
    t.string   "bhl_url",              limit: 4000
    t.integer  "cited_by_id",          limit: 8
    t.integer  "cites_id",             limit: 8
    t.datetime "created_at",                                        null: false
    t.string   "created_by",           limit: 50,                   null: false
    t.boolean  "draft",                             default: false, null: false
    t.integer  "instance_type_id",     limit: 8,                    null: false
    t.integer  "name_id",              limit: 8,                    null: false
    t.integer  "namespace_id",         limit: 8,                    null: false
    t.string   "nomenclatural_status", limit: 50
    t.string   "page",                 limit: 255
    t.string   "page_qualifier",       limit: 255
    t.integer  "parent_id",            limit: 8
    t.integer  "reference_id",         limit: 8,                    null: false
    t.integer  "source_id",            limit: 8
    t.string   "source_id_string",     limit: 100
    t.string   "source_system",        limit: 50
    t.boolean  "trash",                             default: false, null: false
    t.datetime "updated_at",                                        null: false
    t.string   "updated_by",           limit: 1000,                 null: false
    t.boolean  "valid_record",                      default: false, null: false
    t.string   "verbatim_name_string", limit: 255
  end

  add_index "instance", ["cited_by_id"], name: "instance_citedby_index", using: :btree
  add_index "instance", ["cites_id"], name: "instance_cites_index", using: :btree
  add_index "instance", ["instance_type_id"], name: "instance_instancetype_index", using: :btree
  add_index "instance", ["name_id"], name: "instance_name_index", using: :btree
  add_index "instance", ["namespace_id", "source_id", "source_system"], name: "instance_source_index", using: :btree
  add_index "instance", ["parent_id"], name: "instance_parent_index", using: :btree
  add_index "instance", ["reference_id"], name: "instance_reference_index", using: :btree
  add_index "instance", ["source_id_string"], name: "instance_source_string_index", using: :btree
  add_index "instance", ["source_system"], name: "instance_system_index", using: :btree

  create_table "instance_note", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",         limit: 8,    default: 0,     null: false
    t.datetime "created_at",                                        null: false
    t.string   "created_by",           limit: 50,                   null: false
    t.integer  "instance_id",          limit: 8,                    null: false
    t.integer  "instance_note_key_id", limit: 8,                    null: false
    t.integer  "namespace_id",         limit: 8,                    null: false
    t.integer  "source_id",            limit: 8
    t.string   "source_id_string",     limit: 100
    t.string   "source_system",        limit: 50
    t.boolean  "trash",                             default: false, null: false
    t.datetime "updated_at",                                        null: false
    t.string   "updated_by",           limit: 50,                   null: false
    t.string   "value",                limit: 4000,                 null: false
  end

  add_index "instance_note", ["instance_id"], name: "note_instance_index", using: :btree
  add_index "instance_note", ["instance_note_key_id"], name: "note_key_index", using: :btree
  add_index "instance_note", ["namespace_id", "source_id", "source_system"], name: "note_source_index", using: :btree
  add_index "instance_note", ["source_id_string"], name: "note_source_string_index", using: :btree
  add_index "instance_note", ["source_system"], name: "note_system_index", using: :btree

  create_table "instance_note_key", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,   default: 0,     null: false
    t.boolean "deprecated",                   default: false, null: false
    t.string  "name",             limit: 255,                 null: false
    t.integer "sort_order",                   default: 0,     null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "instance_note_key", ["name"], name: "uk_a0justk7c77bb64o6u1riyrlh", unique: true, using: :btree
  add_index "instance_note_key", ["rdf_id"], name: "instance_note_key_rdfid", using: :btree

  create_table "instance_type", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",       limit: 8,   default: 0,     null: false
    t.boolean "citing",                         default: false, null: false
    t.boolean "deprecated",                     default: false, null: false
    t.boolean "doubtful",                       default: false, null: false
    t.boolean "misapplied",                     default: false, null: false
    t.string  "name",               limit: 255,                 null: false
    t.boolean "nomenclatural",                  default: false, null: false
    t.boolean "primary_instance",               default: false, null: false
    t.boolean "pro_parte",                      default: false, null: false
    t.boolean "protologue",                     default: false, null: false
    t.boolean "relationship",                   default: false, null: false
    t.boolean "secondary_instance",             default: false, null: false
    t.integer "sort_order",                     default: 0,     null: false
    t.boolean "standalone",                     default: false, null: false
    t.boolean "synonym",                        default: false, null: false
    t.boolean "taxonomic",                      default: false, null: false
    t.boolean "unsourced",                      default: false, null: false
    t.text    "description_html"
    t.string  "rdf_id",             limit: 50
  end

  add_index "instance_type", ["name"], name: "uk_j5337m9qdlirvd49v4h11t1lk", unique: true, using: :btree
  add_index "instance_type", ["rdf_id"], name: "instance_type_rdfid", using: :btree

  create_table "language", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version", limit: 8,  default: 0, null: false
    t.string  "iso6391code",  limit: 2
    t.string  "iso6393code",  limit: 3,              null: false
    t.string  "name",         limit: 50,             null: false
  end

  add_index "language", ["iso6391code"], name: "uk_hghw87nl0ho38f166atlpw2hy", unique: true, using: :btree
  add_index "language", ["iso6393code"], name: "uk_rpsahneqboogcki6p1bpygsua", unique: true, using: :btree
  add_index "language", ["name"], name: "uk_g8hr207ijpxlwu10pewyo65gv", unique: true, using: :btree

  create_table "locale", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",       limit: 8,  default: 0, null: false
    t.string  "locale_name_string", limit: 50,             null: false
  end

  add_index "locale", ["locale_name_string"], name: "uk_qjkskvl9hx0w78truoyq9teju", unique: true, using: :btree

  create_table "name", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",          limit: 8,    default: 0,     null: false
    t.integer  "author_id",             limit: 8
    t.integer  "base_author_id",        limit: 8
    t.datetime "created_at",                                         null: false
    t.string   "created_by",            limit: 50,                   null: false
    t.integer  "duplicate_of_id",       limit: 8
    t.integer  "ex_author_id",          limit: 8
    t.integer  "ex_base_author_id",     limit: 8
    t.string   "full_name",             limit: 512
    t.string   "full_name_html",        limit: 2048
    t.string   "name_element",          limit: 255
    t.integer  "name_rank_id",          limit: 8,                    null: false
    t.integer  "name_status_id",        limit: 8,                    null: false
    t.integer  "name_type_id",          limit: 8,                    null: false
    t.integer  "namespace_id",          limit: 8,                    null: false
    t.boolean  "orth_var",                           default: false, null: false
    t.integer  "parent_id",             limit: 8
    t.integer  "sanctioning_author_id", limit: 8
    t.integer  "second_parent_id",      limit: 8
    t.string   "simple_name",           limit: 250
    t.string   "simple_name_html",      limit: 2048
    t.integer  "source_dup_of_id",      limit: 8
    t.integer  "source_id",             limit: 8
    t.string   "source_id_string",      limit: 100
    t.string   "source_system",         limit: 50
    t.string   "status_summary",        limit: 50
    t.boolean  "trash",                              default: false, null: false
    t.datetime "updated_at",                                         null: false
    t.string   "updated_by",            limit: 50,                   null: false
    t.boolean  "valid_record",                       default: false, null: false
    t.integer  "why_is_this_here_id",   limit: 8
    t.string   "verbatim_rank",         limit: 50
    t.string   "sort_name",             limit: 250
  end

  add_index "name", ["author_id"], name: "name_author_index", using: :btree
  add_index "name", ["base_author_id"], name: "name_baseauthor_index", using: :btree
  add_index "name", ["duplicate_of_id"], name: "name_duplicate_of_id_index", using: :btree
  add_index "name", ["ex_author_id"], name: "name_exauthor_index", using: :btree
  add_index "name", ["ex_base_author_id"], name: "name_exbaseauthor_index", using: :btree
  add_index "name", ["full_name"], name: "name_full_name_index", using: :btree
  add_index "name", ["name_element"], name: "name_name_element_index", using: :btree
  add_index "name", ["name_rank_id"], name: "name_rank_index", using: :btree
  add_index "name", ["name_status_id"], name: "name_status_index", using: :btree
  add_index "name", ["name_type_id"], name: "name_type_index", using: :btree
  add_index "name", ["namespace_id", "source_id", "source_system"], name: "name_source_index", using: :btree
  add_index "name", ["parent_id"], name: "name_parent_id_ndx", using: :btree
  add_index "name", ["sanctioning_author_id"], name: "name_sanctioningauthor_index", using: :btree
  add_index "name", ["second_parent_id"], name: "name_second_parent_id_ndx", using: :btree
  add_index "name", ["simple_name"], name: "name_simple_name_index", using: :btree
  add_index "name", ["source_id_string"], name: "name_source_string_index", using: :btree
  add_index "name", ["source_system"], name: "name_system_index", using: :btree
  add_index "name", ["why_is_this_here_id"], name: "name_whyisthishere_index", using: :btree

  create_table "name_category", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,  default: 0, null: false
    t.string  "name",             limit: 50,             null: false
    t.integer "sort_order",                  default: 0, null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "name_category", ["name"], name: "uk_rxqxoenedjdjyd4x7c98s59io", unique: true, using: :btree
  add_index "name_category", ["rdf_id"], name: "name_category_rdfid", using: :btree

  create_table "name_group", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,  default: 0, null: false
    t.string  "name",             limit: 50
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "name_group", ["name"], name: "uk_5185nbyw5hkxqyyqgylfn2o6d", unique: true, using: :btree
  add_index "name_group", ["rdf_id"], name: "name_group_rdfid", using: :btree

  create_table "name_part", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",        limit: 8,  default: 0, null: false
    t.integer "name_id",             limit: 8,              null: false
    t.integer "preceding_name_id",   limit: 8,              null: false
    t.string  "preceding_name_type", limit: 50,             null: false
  end

  add_index "name_part", ["name_id"], name: "name_part_name_id_ndx", using: :btree
  add_index "name_part", ["preceding_name_type"], name: "preceding_name_type_index", using: :btree

  create_table "name_rank", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,  default: 0,     null: false
    t.string  "abbrev",           limit: 20,                 null: false
    t.boolean "deprecated",                  default: false, null: false
    t.boolean "has_parent",                  default: false, null: false
    t.boolean "italicize",                   default: false, null: false
    t.boolean "major",                       default: false, null: false
    t.string  "name",             limit: 50,                 null: false
    t.integer "name_group_id",    limit: 8,                  null: false
    t.integer "parent_rank_id",   limit: 8
    t.integer "sort_order",                  default: 0,     null: false
    t.boolean "visible_in_name",             default: true,  null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "name_rank", ["rdf_id"], name: "name_rank_rdfid", using: :btree

  create_table "name_status", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,  default: 0,     null: false
    t.boolean "display",                     default: true,  null: false
    t.string  "name",             limit: 50
    t.integer "name_group_id",    limit: 8,                  null: false
    t.integer "name_status_id",   limit: 8
    t.boolean "nom_illeg",                   default: false, null: false
    t.boolean "nom_inval",                   default: false, null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "name_status", ["name"], name: "uk_se7crmfnhjmyvirp3p9hiqerx", unique: true, using: :btree
  add_index "name_status", ["rdf_id"], name: "name_status_rdfid", using: :btree

  create_table "name_tag", id: :bigserial, force: :cascade do |t|
    t.string  "name",         limit: 255,             null: false
    t.integer "lock_version", limit: 8,   default: 0, null: false
  end

  add_index "name_tag", ["name"], name: "uk_o4su6hi7vh0yqs4c1dw0fsf1e", unique: true, using: :btree

  create_table "name_tag_name", id: false, force: :cascade do |t|
    t.integer  "name_id",    limit: 8,   null: false
    t.integer  "tag_id",     limit: 8,   null: false
    t.datetime "created_at",             null: false
    t.string   "created_by", limit: 255, null: false
    t.datetime "updated_at",             null: false
    t.string   "updated_by", limit: 255, null: false
  end

  add_index "name_tag_name", ["name_id"], name: "name_tag_name_index", using: :btree
  add_index "name_tag_name", ["tag_id"], name: "name_tag_tag_index", using: :btree

  create_table "name_tree_path", id: :bigserial, force: :cascade do |t|
    t.integer "version",      limit: 8, null: false
    t.integer "inserted",     limit: 8, null: false
    t.integer "name_id",      limit: 8, null: false
    t.text    "name_id_path",           null: false
    t.text    "name_path",              null: false
    t.integer "next_id",      limit: 8
    t.integer "parent_id",    limit: 8
    t.text    "rank_path",              null: false
    t.integer "tree_id",      limit: 8, null: false
  end

  add_index "name_tree_path", ["name_id", "tree_id"], name: "name_tree_path_treename_index", using: :btree

  create_table "name_type", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,   default: 0,     null: false
    t.boolean "autonym",                      default: false, null: false
    t.string  "connector",        limit: 1
    t.boolean "cultivar",                     default: false, null: false
    t.boolean "formula",                      default: false, null: false
    t.boolean "hybrid",                       default: false, null: false
    t.string  "name",             limit: 255,                 null: false
    t.integer "name_category_id", limit: 8,                   null: false
    t.integer "name_group_id",    limit: 8,                   null: false
    t.boolean "scientific",                   default: false, null: false
    t.integer "sort_order",                   default: 0,     null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
    t.boolean "deprecated",                   default: false, null: false
  end

  add_index "name_type", ["name"], name: "uk_314uhkq8i7r46050kd1nfrs95", unique: true, using: :btree
  add_index "name_type", ["rdf_id"], name: "name_type_rdfid", using: :btree

  create_table "namespace", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,   default: 0, null: false
    t.string  "name",             limit: 255,             null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "namespace", ["name"], name: "uk_eq2y9mghytirkcofquanv5frf", unique: true, using: :btree
  add_index "namespace", ["rdf_id"], name: "namespace_rdfid", using: :btree

  create_table "nomenclatural_event_type", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",             limit: 8,  default: 0, null: false
    t.integer "name_group_id",            limit: 8,              null: false
    t.string  "nomenclatural_event_type", limit: 50
    t.text    "description_html"
    t.string  "rdf_id",                   limit: 50
  end

  add_index "nomenclatural_event_type", ["rdf_id"], name: "nomenclatural_event_type_rdfid", using: :btree

  create_table "notification", id: :bigserial, force: :cascade do |t|
    t.integer "version",   limit: 8,   null: false
    t.string  "message",   limit: 255, null: false
    t.integer "object_id", limit: 8
  end

  create_table "nsl_simple_name", id: :bigserial, force: :cascade do |t|
    t.string   "apc_comment",           limit: 4000
    t.string   "apc_distribution",      limit: 4000
    t.boolean  "apc_excluded",                       default: false, null: false
    t.string   "apc_familia",           limit: 255
    t.integer  "apc_instance_id",       limit: 8
    t.string   "apc_name",              limit: 512
    t.boolean  "apc_proparte",                       default: false, null: false
    t.string   "apc_relationship_type", limit: 255
    t.boolean  "apni",                               default: false
    t.string   "author",                limit: 255
    t.string   "authority",             limit: 255
    t.boolean  "autonym",                            default: false
    t.string   "base_name_author",      limit: 255
    t.string   "classifications",       limit: 255
    t.string   "classis",               limit: 255
    t.datetime "created_at"
    t.string   "created_by",            limit: 255
    t.boolean  "cultivar",                           default: false, null: false
    t.string   "cultivar_name",         limit: 255
    t.integer  "dup_of_id",             limit: 8
    t.string   "ex_author",             limit: 255
    t.string   "ex_base_name_author",   limit: 255
    t.string   "familia",               limit: 255
    t.integer  "family_nsl_id",         limit: 8
    t.boolean  "formula",                            default: false, null: false
    t.string   "full_name_html",        limit: 2048
    t.string   "genus",                 limit: 255
    t.integer  "genus_nsl_id",          limit: 8
    t.boolean  "homonym",                            default: false
    t.boolean  "hybrid",                             default: false
    t.string   "infraspecies",          limit: 255
    t.string   "name",                  limit: 255,                  null: false
    t.string   "name_element",          limit: 255
    t.integer  "name_rank_id",          limit: 8,                    null: false
    t.integer  "name_status_id",        limit: 8,                    null: false
    t.integer  "name_type_id",          limit: 8,                    null: false
    t.string   "name_type_name",        limit: 255,                  null: false
    t.boolean  "nom_illeg",                          default: false
    t.boolean  "nom_inval",                          default: false
    t.string   "nom_stat",              limit: 255,                  null: false
    t.integer  "parent_nsl_id",         limit: 8
    t.integer  "proto_year",            limit: 2
    t.string   "rank",                  limit: 255,                  null: false
    t.string   "rank_abbrev",           limit: 255
    t.integer  "rank_sort_order"
    t.string   "sanctioning_author",    limit: 255
    t.boolean  "scientific",                         default: false
    t.integer  "second_parent_nsl_id",  limit: 8
    t.string   "simple_name_html",      limit: 2048
    t.string   "species",               limit: 255
    t.integer  "species_nsl_id",        limit: 8
    t.string   "subclassis",            limit: 255
    t.string   "taxon_name",            limit: 512,                  null: false
    t.datetime "updated_at"
    t.string   "updated_by",            limit: 255
    t.string   "basionym",              limit: 512
    t.string   "proto_citation",        limit: 512
    t.integer  "proto_instance_id",     limit: 8
    t.string   "replaced_synonym",      limit: 512
  end

  create_table "nsl_simple_name_export", id: false, force: :cascade do |t|
    t.text     "id"
    t.string   "apc_comment",           limit: 4000
    t.string   "apc_distribution",      limit: 4000
    t.boolean  "apc_excluded"
    t.string   "apc_familia",           limit: 255
    t.text     "apc_instance_id"
    t.string   "apc_name",              limit: 512
    t.boolean  "apc_proparte"
    t.string   "apc_relationship_type", limit: 255
    t.boolean  "apni"
    t.string   "author",                limit: 255
    t.string   "authority",             limit: 255
    t.boolean  "autonym"
    t.string   "basionym",              limit: 512
    t.string   "base_name_author",      limit: 255
    t.string   "classifications",       limit: 255
    t.datetime "created_at"
    t.string   "created_by",            limit: 255
    t.boolean  "cultivar"
    t.string   "cultivar_name",         limit: 255
    t.string   "ex_author",             limit: 255
    t.string   "ex_base_name_author",   limit: 255
    t.string   "familia",               limit: 255
    t.text     "family_nsl_id"
    t.boolean  "formula"
    t.string   "full_name_html",        limit: 2048
    t.string   "genus",                 limit: 255
    t.text     "genus_nsl_id"
    t.boolean  "homonym"
    t.boolean  "hybrid"
    t.string   "infraspecies",          limit: 255
    t.string   "name",                  limit: 255
    t.string   "classis",               limit: 255
    t.string   "name_element",          limit: 255
    t.string   "subclassis",            limit: 255
    t.string   "name_type_name",        limit: 255
    t.boolean  "nom_illeg"
    t.boolean  "nom_inval"
    t.string   "nom_stat",              limit: 255
    t.text     "parent_nsl_id"
    t.string   "proto_citation",        limit: 512
    t.text     "proto_instance_id"
    t.integer  "proto_year",            limit: 2
    t.string   "rank",                  limit: 255
    t.string   "rank_abbrev",           limit: 255
    t.integer  "rank_sort_order"
    t.string   "replaced_synonym",      limit: 512
    t.string   "sanctioning_author",    limit: 255
    t.boolean  "scientific"
    t.text     "second_parent_nsl_id"
    t.string   "simple_name_html",      limit: 2048
    t.string   "species",               limit: 255
    t.text     "species_nsl_id"
    t.string   "taxon_name",            limit: 512
    t.datetime "updated_at"
    t.string   "updated_by",            limit: 255
  end

  create_table "ref_author_role", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,   default: 0, null: false
    t.string  "name",             limit: 255,             null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "ref_author_role", ["name"], name: "uk_l95kedbafybjpp3h53x8o9fke", unique: true, using: :btree
  add_index "ref_author_role", ["rdf_id"], name: "ref_author_role_rdfid", using: :btree

  create_table "ref_type", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",     limit: 8,  default: 0,     null: false
    t.string  "name",             limit: 50,                 null: false
    t.integer "parent_id",        limit: 8
    t.boolean "parent_optional",             default: false, null: false
    t.text    "description_html"
    t.string  "rdf_id",           limit: 50
  end

  add_index "ref_type", ["name"], name: "uk_4fp66uflo7rgx59167ajs0ujv", unique: true, using: :btree
  add_index "ref_type", ["rdf_id"], name: "ref_type_rdfid", using: :btree

  create_table "reference", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",       limit: 8,    default: 0,     null: false
    t.string   "abbrev_title",       limit: 2000
    t.integer  "author_id",          limit: 8,                    null: false
    t.string   "bhl_url",            limit: 4000
    t.string   "citation",           limit: 4000
    t.string   "citation_html",      limit: 4000
    t.datetime "created_at",                                      null: false
    t.string   "created_by",         limit: 255,                  null: false
    t.string   "display_title",      limit: 2000,                 null: false
    t.string   "doi",                limit: 255
    t.integer  "duplicate_of_id",    limit: 8
    t.string   "edition",            limit: 100
    t.string   "isbn",               limit: 16
    t.string   "issn",               limit: 16
    t.integer  "language_id",        limit: 8,                    null: false
    t.integer  "namespace_id",       limit: 8,                    null: false
    t.string   "notes",              limit: 1000
    t.string   "pages",              limit: 1000
    t.integer  "parent_id",          limit: 8
    t.string   "publication_date",   limit: 50
    t.boolean  "published",                       default: false, null: false
    t.string   "published_location", limit: 1000
    t.string   "publisher",          limit: 1000
    t.integer  "ref_author_role_id", limit: 8,                    null: false
    t.integer  "ref_type_id",        limit: 8,                    null: false
    t.integer  "source_id",          limit: 8
    t.string   "source_id_string",   limit: 100
    t.string   "source_system",      limit: 50
    t.string   "title",              limit: 2000,                 null: false
    t.string   "tl2",                limit: 30
    t.boolean  "trash",                           default: false, null: false
    t.datetime "updated_at",                                      null: false
    t.string   "updated_by",         limit: 1000,                 null: false
    t.boolean  "valid_record",                    default: false, null: false
    t.string   "verbatim_author",    limit: 1000
    t.string   "verbatim_citation",  limit: 2000
    t.string   "verbatim_reference", limit: 1000
    t.string   "volume",             limit: 100
    t.integer  "year"
  end

  add_index "reference", ["author_id"], name: "reference_author_index", using: :btree
  add_index "reference", ["doi"], name: "uk_kqwpm0crhcq4n9t9uiyfxo2df", unique: true, using: :btree
  add_index "reference", ["namespace_id", "source_id", "source_system"], name: "ref_source_index", using: :btree
  add_index "reference", ["parent_id"], name: "reference_parent_index", using: :btree
  add_index "reference", ["ref_author_role_id"], name: "reference_authorrole_index", using: :btree
  add_index "reference", ["ref_type_id"], name: "reference_type_index", using: :btree
  add_index "reference", ["source_id_string"], name: "ref_source_string_index", using: :btree
  add_index "reference", ["source_system"], name: "ref_system_index", using: :btree

  create_table "trashed_item", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",      limit: 8,                             default: 0, null: false
    t.datetime "created_at",                                                          null: false
    t.string   "created_by",        limit: 4000,                                      null: false
    t.decimal  "trashable_id",                   precision: 19, scale: 2,             null: false
    t.string   "trashable_type",    limit: 4000,                                      null: false
    t.integer  "trashing_event_id", limit: 8
    t.datetime "updated_at",                                                          null: false
    t.string   "updated_by",        limit: 4000,                                      null: false
  end

  create_table "trashing_event", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version", limit: 8,    default: 0, null: false
    t.datetime "created_at",                            null: false
    t.string   "created_by",   limit: 4000,             null: false
    t.datetime "updated_at",                            null: false
    t.string   "updated_by",   limit: 4000,             null: false
  end

  create_table "tree_arrangement", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version", limit: 8,   default: 0, null: false
    t.string  "tree_type",                            null: false
    t.string  "description",  limit: 255
    t.string  "label",        limit: 50
    t.integer "node_id",      limit: 8
    t.string  "is_synthetic",                         null: false
    t.string  "title",        limit: 50
    t.integer "namespace_id", limit: 8
  end

  add_index "tree_arrangement", ["label"], name: "tree_arrangement_label", using: :btree
  add_index "tree_arrangement", ["label"], name: "uk_y303qbh1ijdg3sncl9vlxus0", unique: true, using: :btree
  add_index "tree_arrangement", ["node_id"], name: "tree_arrangement_node", using: :btree

  create_table "tree_event", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version", limit: 8,   default: 0, null: false
    t.string   "auth_user",    limit: 255,             null: false
    t.string   "note",         limit: 255
    t.datetime "time_stamp",                           null: false
    t.integer  "namespace_id", limit: 8
  end

  create_table "tree_link", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",        limit: 8,   default: 0, null: false
    t.integer "link_seq",                                    null: false
    t.integer "subnode_id",          limit: 8,               null: false
    t.integer "supernode_id",        limit: 8,               null: false
    t.string  "is_synthetic",                                null: false
    t.string  "type_uri_id_part",    limit: 255
    t.integer "type_uri_ns_part_id", limit: 8,               null: false
    t.string  "versioning_method",                           null: false
  end

  add_index "tree_link", ["subnode_id"], name: "tree_link_subnode", using: :btree
  add_index "tree_link", ["supernode_id", "link_seq"], name: "idx_tree_link_seq", unique: true, using: :btree
  add_index "tree_link", ["supernode_id"], name: "tree_link_supernode", using: :btree

  create_table "tree_node", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",            limit: 8,    default: 0, null: false
    t.integer "checked_in_at_id",        limit: 8
    t.string  "internal_type",           limit: 255,              null: false
    t.string  "literal",                 limit: 4096
    t.string  "name_uri_id_part",        limit: 255
    t.integer "name_uri_ns_part_id",     limit: 8
    t.integer "next_node_id",            limit: 8
    t.integer "prev_node_id",            limit: 8
    t.integer "replaced_at_id",          limit: 8
    t.string  "resource_uri_id_part",    limit: 255
    t.integer "resource_uri_ns_part_id", limit: 8
    t.integer "tree_arrangement_id",     limit: 8
    t.string  "is_synthetic",                                     null: false
    t.string  "taxon_uri_id_part",       limit: 255
    t.integer "taxon_uri_ns_part_id",    limit: 8
    t.string  "type_uri_id_part",        limit: 255
    t.integer "type_uri_ns_part_id",     limit: 8,                null: false
    t.integer "name_id",                 limit: 8
    t.integer "instance_id",             limit: 8
  end

  add_index "tree_node", ["instance_id", "tree_arrangement_id"], name: "idx_tree_node_instance_id_in", using: :btree
  add_index "tree_node", ["instance_id"], name: "idx_tree_node_instance_id", using: :btree
  add_index "tree_node", ["literal"], name: "idx_tree_node_literal", using: :btree
  add_index "tree_node", ["name_id", "tree_arrangement_id"], name: "idx_tree_node_name_id_in", using: :btree
  add_index "tree_node", ["name_id"], name: "idx_tree_node_name_id", using: :btree
  add_index "tree_node", ["name_uri_id_part", "name_uri_ns_part_id", "tree_arrangement_id"], name: "idx_tree_node_name_in", using: :btree
  add_index "tree_node", ["name_uri_id_part", "name_uri_ns_part_id"], name: "idx_tree_node_name", using: :btree
  add_index "tree_node", ["next_node_id"], name: "tree_node_next", using: :btree
  add_index "tree_node", ["prev_node_id"], name: "tree_node_prev", using: :btree
  add_index "tree_node", ["resource_uri_id_part", "resource_uri_ns_part_id", "tree_arrangement_id"], name: "idx_tree_node_resource_in", using: :btree
  add_index "tree_node", ["resource_uri_id_part", "resource_uri_ns_part_id"], name: "idx_tree_node_resource", using: :btree
  add_index "tree_node", ["taxon_uri_id_part", "taxon_uri_ns_part_id", "tree_arrangement_id"], name: "idx_tree_node_taxon_in", using: :btree
  add_index "tree_node", ["taxon_uri_id_part", "taxon_uri_ns_part_id"], name: "idx_tree_node_taxon", using: :btree

  create_table "tree_uri_ns", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version",           limit: 8,   default: 0, null: false
    t.string  "description",            limit: 255
    t.integer "id_mapper_namespace_id", limit: 8
    t.string  "id_mapper_system",       limit: 255
    t.string  "label",                  limit: 20,              null: false
    t.string  "owner_uri_id_part",      limit: 255
    t.integer "owner_uri_ns_part_id",   limit: 8
    t.string  "title",                  limit: 255
    t.string  "uri",                    limit: 255
  end

  add_index "tree_uri_ns", ["label"], name: "idx_tree_uri_ns_label", using: :btree
  add_index "tree_uri_ns", ["label"], name: "uk_5smmen5o34hs50jxd247k81ia", unique: true, using: :btree
  add_index "tree_uri_ns", ["uri"], name: "idx_tree_uri_ns_uri", using: :btree
  add_index "tree_uri_ns", ["uri"], name: "uk_70p0ys3l5v6s9dqrpjr3u3rrf", unique: true, using: :btree

  create_table "user_query", id: :bigserial, force: :cascade do |t|
    t.integer  "lock_version",       limit: 8,                             default: 0,     null: false
    t.datetime "created_at",                                                               null: false
    t.boolean  "query_completed",                                          default: false, null: false
    t.boolean  "query_started",                                            default: false, null: false
    t.decimal  "record_count",                    precision: 19, scale: 2,                 null: false
    t.datetime "search_finished_at"
    t.string   "search_info",        limit: 500
    t.string   "search_model",       limit: 4000
    t.text     "search_result"
    t.datetime "search_started_at"
    t.string   "search_terms",       limit: 4000
    t.boolean  "trash",                                                    default: false, null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "why_is_this_here", id: :bigserial, force: :cascade do |t|
    t.integer "lock_version", limit: 8,  default: 0, null: false
    t.string  "name",         limit: 50,             null: false
    t.integer "sort_order",              default: 0, null: false
  end

  add_index "why_is_this_here", ["name"], name: "uk_sv1q1i7xve7xgmkwvmdbeo1mb", unique: true, using: :btree

  add_foreign_key "author", "author", column: "duplicate_of_id", name: "fk_6a4p11f1bt171w09oo06m0wag"
  add_foreign_key "author", "namespace", name: "fk_p0ysrub11cm08xnhrbrfrvudh"
  add_foreign_key "comment", "author", name: "fk_9aq5p2jgf17y6b38x5ayd90oc"
  add_foreign_key "comment", "instance", name: "fk_6oqj6vquqc33cyawn853hfu5g"
  add_foreign_key "comment", "name", name: "fk_h9t5eaaqhnqwrc92rhryyvdcf"
  add_foreign_key "comment", "reference", name: "fk_3tfkdcmf6rg6hcyiu8t05er7x"
  add_foreign_key "external_ref", "instance", name: "fk_4g2i2qry4941xmqijgeo8ns2h"
  add_foreign_key "external_ref", "name", name: "fk_bu7q5itmt7w7q1bex049xvac7"
  add_foreign_key "external_ref", "reference", name: "fk_f7igpcpvgcmdfb7v3bgjluqsf"
  add_foreign_key "id_mapper", "namespace", name: "fk_qiy281xsleyhjgr0eu1sboagm"
  add_foreign_key "instance", "instance", column: "cited_by_id", name: "fk_pr2f6peqhnx9rjiwkr5jgc5be"
  add_foreign_key "instance", "instance", column: "cites_id", name: "fk_30enb6qoexhuk479t75apeuu5"
  add_foreign_key "instance", "instance", column: "parent_id", name: "fk_hb0xb97midopfgrm2k5fpe3p1"
  add_foreign_key "instance", "instance_type", name: "fk_o80rrtl8xwy4l3kqrt9qv0mnt"
  add_foreign_key "instance", "name", name: "fk_gdunt8xo68ct1vfec9c6x5889"
  add_foreign_key "instance", "namespace", name: "fk_gtkjmbvk6uk34fbfpy910e7t6"
  add_foreign_key "instance", "reference", name: "fk_lumlr5avj305pmc4hkjwaqk45"
  add_foreign_key "instance_note", "instance", name: "fk_bw41122jb5rcu8wfnog812s97"
  add_foreign_key "instance_note", "instance_note_key", name: "fk_he1t3ug0o7ollnk2jbqaouooa"
  add_foreign_key "instance_note", "namespace", name: "fk_f6s94njexmutjxjv8t5dy1ugt"
  add_foreign_key "name", "author", column: "base_author_id", name: "fk_coqxx3ewgiecsh3t78yc70b35"
  add_foreign_key "name", "author", column: "ex_author_id", name: "fk_sgvxmyj7r9g4wy9c4hd1yn4nu"
  add_foreign_key "name", "author", column: "ex_base_author_id", name: "fk_rp659tjcxokf26j8551k6an2y"
  add_foreign_key "name", "author", column: "sanctioning_author_id", name: "fk_ai81l07vh2yhmthr3582igo47"
  add_foreign_key "name", "author", name: "fk_airfjupm6ohehj1lj82yqkwdx"
  add_foreign_key "name", "name", column: "duplicate_of_id", name: "fk_3pqdqa03w5c6h4yyrrvfuagos"
  add_foreign_key "name", "name", column: "parent_id", name: "fk_dd33etb69v5w5iah1eeisy7yt"
  add_foreign_key "name", "name", column: "second_parent_id", name: "fk_5gp2lfblqq94c4ud3340iml0l"
  add_foreign_key "name", "name_rank", name: "fk_sk2iikq8wla58jeypkw6h74hc"
  add_foreign_key "name", "name_status", name: "fk_5fpm5u0ukiml9nvmq14bd7u51"
  add_foreign_key "name", "name_type", name: "fk_bcef76k0ijrcquyoc0yxehxfp"
  add_foreign_key "name", "namespace", name: "fk_156ncmx4599jcsmhh5k267cjv"
  add_foreign_key "name", "why_is_this_here", name: "fk_dqhn53mdh0n77xhsw7l5dgd38"
  add_foreign_key "name_part", "name", column: "preceding_name_id", name: "fk_pj38oewhgjq8rp08fc9cviteu"
  add_foreign_key "name_part", "name", name: "fk_s13ituehdpf6uh859umme7g1j"
  add_foreign_key "name_rank", "name_group", name: "fk_p3lpayfbl9s3hshhoycfj82b9"
  add_foreign_key "name_rank", "name_rank", column: "parent_rank_id", name: "fk_r67um91pujyfrx7h1cifs3cmb"
  add_foreign_key "name_status", "name_group", name: "fk_swotu3c2gy1hp8f6ekvuo7s26"
  add_foreign_key "name_status", "name_status", name: "fk_g4o6xditli5a0xrm6eqc6h9gw"
  add_foreign_key "name_tag_name", "name", name: "fk_22wdc2pxaskytkgpdgpyok07n"
  add_foreign_key "name_tag_name", "name_tag", column: "tag_id", name: "fk_2uiijd73snf6lh5s6a82yjfin"
  add_foreign_key "name_type", "name_category", name: "fk_10d0jlulq2woht49j5ccpeehu"
  add_foreign_key "name_type", "name_group", name: "fk_5r3o78sgdbxsf525hmm3t44gv"
  add_foreign_key "nomenclatural_event_type", "name_group", name: "fk_ql5g85814a9y57c1ifd0nkq3v"
  add_foreign_key "nsl_simple_name", "instance", column: "apc_instance_id", name: "fk_lgtnu32ysbg6l2ys5d6bhfgmq"
  add_foreign_key "nsl_simple_name", "instance", column: "proto_instance_id", name: "fk_59i6is32bt6v19i51ql9n2r9i"
  add_foreign_key "nsl_simple_name", "name", column: "family_nsl_id", name: "fk_on28vygd1e7aqn9owbhv3u23h"
  add_foreign_key "nsl_simple_name", "name", column: "genus_nsl_id", name: "fk_ctg301hhg3x41rjl09d7noti1"
  add_foreign_key "nsl_simple_name", "name", column: "parent_nsl_id", name: "fk_kquvd2hkcl7aj2vhylvp1k7vb"
  add_foreign_key "nsl_simple_name", "name", column: "second_parent_nsl_id", name: "fk_mvjeehgt584v9ep11ixe1iyok"
  add_foreign_key "nsl_simple_name", "name", column: "species_nsl_id", name: "fk_rpqdbhi21sdix5tmmj5ul61su"
  add_foreign_key "nsl_simple_name", "name_rank", name: "fk_k4ryd8xarm9hhk1aitqtfg0tb"
  add_foreign_key "nsl_simple_name", "name_status", name: "fk_bexlla3pvlm2x8err16puv16f"
  add_foreign_key "nsl_simple_name", "name_type", name: "fk_gbcxpwubk8cdlh5fxnd3ln4up"
  add_foreign_key "ref_type", "ref_type", column: "parent_id", name: "fk_51alfoe7eobwh60yfx45y22ay"
  add_foreign_key "reference", "author", name: "fk_p8lhsoo01164dsvvwxob0w3sp"
  add_foreign_key "reference", "language", name: "fk_1qx84m8tuk7vw2diyxfbj5r2n"
  add_foreign_key "reference", "namespace", name: "fk_am2j11kvuwl19gqewuu18gjjm"
  add_foreign_key "reference", "ref_author_role", name: "fk_a98ei1lxn89madjihel3cvi90"
  add_foreign_key "reference", "ref_type", name: "fk_dm9y4p9xpsc8m7vljbohubl7x"
  add_foreign_key "reference", "reference", column: "duplicate_of_id", name: "fk_3min66ljijxavb0fjergx5dpm"
  add_foreign_key "reference", "reference", column: "parent_id", name: "fk_cr9avt4miqikx4kk53aflnnkd"
  add_foreign_key "trashed_item", "trashing_event", name: "fk_bd6arfjuj28nolsc58i345ybg"
  add_foreign_key "tree_arrangement", "namespace", name: "tree_arrangement_namespace_id_fkey"
  add_foreign_key "tree_arrangement", "tree_node", column: "node_id", name: "fk_fvfq13j3dqv994o9vg54yj5kk"
  add_foreign_key "tree_event", "namespace", name: "tree_event_namespace_id_fkey"
  add_foreign_key "tree_link", "tree_node", column: "subnode_id", name: "fk_tgankaahxgr4p0mw4opafah05"
  add_foreign_key "tree_link", "tree_node", column: "supernode_id", name: "fk_kqshktm171nwvk38ot4d12w6b"
  add_foreign_key "tree_link", "tree_uri_ns", column: "type_uri_ns_part_id", name: "fk_2dk33tolvn16lfmp25nk2584y"
  add_foreign_key "tree_node", "instance", name: "fk_1g9477sa8plad5cxkxmiuh5b"
  add_foreign_key "tree_node", "name", name: "fk_eqw4xo7vty6e4tq8hy34c51om"
  add_foreign_key "tree_node", "tree_arrangement", name: "fk_t6kkvm8ubsiw6fqg473j0gjga"
  add_foreign_key "tree_node", "tree_event", column: "checked_in_at_id", name: "fk_nlq0qddnhgx65iojhj2xm8tay"
  add_foreign_key "tree_node", "tree_event", column: "replaced_at_id", name: "fk_pc0tkp9bgp1cxull530y60v46"
  add_foreign_key "tree_node", "tree_node", column: "next_node_id", name: "fk_sbuntfo4jfai44yjh9o09vu6s"
  add_foreign_key "tree_node", "tree_node", column: "prev_node_id", name: "fk_budb70h51jhcxe7qbtpea0hi2"
  add_foreign_key "tree_node", "tree_uri_ns", column: "name_uri_ns_part_id", name: "fk_gc6f9ykh7eaflvty9tr6n4cb6"
  add_foreign_key "tree_node", "tree_uri_ns", column: "resource_uri_ns_part_id", name: "fk_4y1qy9beekbv71e9i6hto6hun"
  add_foreign_key "tree_node", "tree_uri_ns", column: "taxon_uri_ns_part_id", name: "fk_16c4wgya68bwotwn6f50dhw69"
  add_foreign_key "tree_node", "tree_uri_ns", column: "type_uri_ns_part_id", name: "fk_oge4ibjd3ff3oyshexl6set2u"
  add_foreign_key "tree_uri_ns", "tree_uri_ns", column: "owner_uri_ns_part_id", name: "fk_q9k8he941kvl07j2htmqxq35v"
      create_view :accepted_name_vw, sql_definition:<<-SQL
        SELECT accepted.id,
  accepted.simple_name,
  accepted.full_name,
  tree_node.type_uri_id_part AS type_code,
  instance.id AS instance_id,
  tree_node.id AS tree_node_id,
  0 AS accepted_id,
  ''::character varying AS accepted_full_name,
  accepted.name_status_id,
  instance.reference_id,
  accepted.name_rank_id,
  accepted.sort_name
 FROM (((name accepted
   JOIN instance ON ((accepted.id = instance.name_id)))
   JOIN tree_node ON ((accepted.id = tree_node.name_id)))
   JOIN tree_arrangement ta ON ((tree_node.tree_arrangement_id = ta.id)))
WHERE (((((ta.label)::text = 'APC'::text) AND (tree_node.next_node_id IS NULL)) AND (tree_node.checked_in_at_id IS NOT NULL)) AND (instance.id = tree_node.instance_id));
      SQL

end
